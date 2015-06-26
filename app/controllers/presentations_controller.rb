class PresentationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @presentations = Presentation.is_public.all
  end

  def show
    @user = User.find_by!(username: params[:username])
    @presentation = @user.presentations.is_public.find(params[:id])
  end

  def search
    search_param = { query: { match: { body: { query: params[:q], operator: "and" } } } }
    presentation_ids = PresentationOutline.search(search_param).map(&:presentation_id)
    @presentations = Presentation.is_public.ordered_find_by_id(presentation_ids)
    render "index"
  end
end
