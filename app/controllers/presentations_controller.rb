class PresentationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @presentations = Presentation.preload(:user).
                     is_public.
                     published_at_desc.
                     paginate(page: params[:page])
  end

  def show
    @user = User.find_by!(username: params[:username])
    @presentation = @user.presentations.is_public.find(params[:id])
    render layout: "viewer"
  end

  def search
    search_param = { query: { match: { body: { query: params[:q], operator: "and" } } } }
    presentation_ids = PresentationOutline.search(search_param).map(&:presentation_id)
    # TODO: id の時点で paginate できるはずなので ordered_find_by_id にかける前に処理したい
    @presentations = Presentation.is_public.ordered_find_by_id(presentation_ids).compact.paginate(page: params[:page])
    render "index"
  end
end
