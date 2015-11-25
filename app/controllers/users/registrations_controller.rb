class Users::RegistrationsController < Devise::RegistrationsController
  # 登録に成功したら session に一時保存していた omniauth 認証情報を破棄
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  rescue ActiveRecord::RecordNotUnique # uniqueness validation は mysql に任せる
    @user.errors.add(:username, I18n.t("errors.messages.taken"))
    render :new
  end

  private

    # create user with user_account
    def build_resource(hash = nil)
      super
      auth = session[:omniauth]
      @user.name = auth.extra.raw_info.name
      account = @user.user_accounts.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      account.build_auth_info(auth)
    end

    def sign_up_params
      params.require(:user).permit(:username)
    end
end
