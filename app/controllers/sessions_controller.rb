class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &. authenticate(params[:session][:password])
      reset_session      # ログインの直前に必ずこれを書くこと
      log_in user
      redirect_to user
    else
      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
      flash.now[:danger] = 'Invalid email/password combination'
    end
  end

  def destroy
  end
end
