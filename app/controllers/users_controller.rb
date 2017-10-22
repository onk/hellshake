class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(username: params[:username])
    @presentations = @user.presentations.preload(:user).
                       is_public.
                       published_at_desc.
                       paginate(page: params[:page])
    render "presentations/index"
  end
end
