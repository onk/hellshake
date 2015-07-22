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
      presentation = current_user.presentations.create(create_presentation_params)
      Ppt2pdfJob.perform_later(presentation)
      redirect_to edit_manage_presentation_path(presentation)
    end

    def edit
      @presentation = current_user.presentations.find(params[:id])
    end

    def update
      @presentation = current_user.presentations.lock.find(params[:id])
      if @presentation.update(update_presentation_params)
        redirect_to manage_presentations_path
      else
        render :edit
      end
    rescue ActiveRecord::RecordNotUnique # uniqueness validation は mysql に任せる
      @presentation.errors.add(:slug, I18n.t("errors.messages.taken"))
      render :edit
    end

    private

      def create_presentation_params
        # FIXIME: params 書き換えるのがイマイチ
        title = File.basename(params[:presentation][:original_file].original_filename, ".*")
        params[:presentation][:title] = title
        params[:presentation][:published_at] = Time.current
        slug = Zipang.to_slug(title)
        if current_user.presentations.where(slug: slug).exists?
          # slug が重複していた場合は現在時刻を付与して重複回避。
          # これで重複したら諦めてエラー
          slug = slug + Time.current.strftime("%Y%m%d%H%M%S")
        end
        params[:presentation][:slug] = slug
        params.require(:presentation).permit(:title, :original_file, :published_at, :slug)
      end

      def update_presentation_params
        params.require(:presentation).permit(:title, :is_public, :published_at, :slug)
      end
  end
end
