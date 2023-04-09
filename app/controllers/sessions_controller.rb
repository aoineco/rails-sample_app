class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &. authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    else
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
      flash.now[:danger] = 'Invalid email/password combination'
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
