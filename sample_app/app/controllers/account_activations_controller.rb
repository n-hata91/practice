class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email]) #urlのメールアドレスから取得
    if user && !user.activated? && user.authenticated?(:activation, params[:id]) #存在する、アクティブでない、本人である場合
      user.activate
      user.update_attribute(:activated, true) #:activedと:a_atを書き換えて
      user.update_attribute(:activated_at, Time.zone.now) #update_attribute's'にするとバリデーションに引っかかる
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
  
end
