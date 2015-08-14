class PresentationsController < ApplicationController
  before_action :authenticate_user!, if: :format_is_not_atom

  def index
    @presentations = Presentation.preload(:user).
                     is_public.
                     published_at_desc.
                     paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @user = User.find_by!(username: params[:username])
    @presentation = @user.presentations.is_public.find_by(slug: params[:slug])
    @presentation.access_count.increment
    render layout: nil
  end

  def search
    search_param = { query: { bool: { must: [
      { multi_match: { minimum_should_match: "100%", query: params[:q], fields: %w(tags title outline) } }
    ] } } }
    @presentations = Presentation.search(search_param).page(params[:page]).records
    render "index"
  end

  private

    def format_is_not_atom
      params[:format] != "atom"
    end
end
