class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user # log_in user_url(usdr)の省略
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user #userが持っているsessionの中に:forwarding_urlがあれば、そっちに移動
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'# == user_url(user)
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
