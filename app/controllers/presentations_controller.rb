class PresentationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show]

  def index
    @presentations = @user.presentations.all
  end

  def show
    @presentation = @user.presentations.find(params[:id])
  end

  def create
  end

  private

    def set_user
      @user = User.find_by!(username: params[:username])
    end
end
