module Manage
  class PresentationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @presentations = current_user.presentations.preload(:user).
                       published_at_desc.
                       paginate(page: params[:page])
      render "presentations/index"
    end

    def create
      presentation = current_user.presentations.create!(create_presentation_params)
      Ppt2pdfJob.perform_later(presentation)
      redirect_to edit_manage_presentation_path(presentation)
    end

    def edit
      @presentation = current_user.presentations.find(params[:id])
    end

    def update
      @presentation = current_user.presentations.lock.find(params[:id])
      if params[:presentation][:original_file]
        @presentation.reupload(params[:presentation][:original_file])
        redirect_to edit_manage_presentation_path(@presentation)
      else
        if @presentation.update(update_presentation_params)
          redirect_to manage_presentations_path
        else
          render :edit
        end
      end
    rescue ActiveRecord::RecordNotUnique # uniqueness validation は mysql に任せる
      @presentation.errors.add(:slug, I18n.t("errors.messages.taken"))
      render :edit
    end

    def destroy
      @presentation = current_user.presentations.lock.find(params[:id])
      @presentation.destroy
      redirect_to manage_presentations_path
    end

    private

      def create_presentation_params
        # FIXIME: params 書き換えるのがイマイチ
        title = File.basename(params[:presentation][:original_file].original_filename, ".*")
        title.encode!("UTF-8", "UTF-8-MAC")
        params[:presentation][:title] = title
        params[:presentation][:published_at] = Time.current
        params.require(:presentation).permit(:title, :original_file, :published_at)
      end

      def update_presentation_params
        params.require(:presentation).permit(:title, :is_public, :published_at, :slug, :tag_list)
      end
  end
end
