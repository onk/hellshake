class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(username: params[:username])
    @presentations = @user.presentations.is_public.all
    render "presentations/index"
  end
end
