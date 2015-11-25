class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth
    auth = request.env["omniauth.auth"]

    if current_user
      # ログイン済みなら既存の ID に紐付ける
      account = current_user.user_accounts.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      account.save_auth_info(auth)
      redirect_to after_sign_in_path_for(current_user)
    else
      # 未ログインの場合は account に紐付いている user でログインする
      account = UserAccount.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      unless account.user
        # 紐付きユーザが存在しない＝新規登録の場合
        session[:omniauth] = auth
        redirect_to new_user_registration_url and return
      end
      account.save_auth_info(auth)
      sign_in_and_redirect(account.user, event: :authentication)
    end
  end
  alias_method :facebook, :auth
  alias_method :twitter,  :auth
end
