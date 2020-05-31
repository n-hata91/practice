module SessionsHelper
  def log_in(user) # 渡されたユーザのIDをセッションへ代入
    session[:user_id] = user.id
  end

  def remember(user) # 記憶トークンを生成してcookieに情報を渡す、IDも暗号化して渡す
    user.remember # 記憶トークンを生成
    cookies.permanent.signed[:user_id] = user.id # IDを永続化、暗号化してcookieに渡す
    cookies.permanent[:remember_token] = user.remember_token # 作った記憶トークンを永続化してcookieに渡す
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])  #session[:user_id] #セッションがあれば...
      @current_user ||= User.find_by(id: user_id) #セッションでユーザ情報を探して利用
    elsif (user_id = cookies.signed[:user_id])  #cookies.signed[:user_id] #セッションはないけどクッキーにはユーザ情報があるなら...
      user = User.find_by(id: user_id) #クッキーから情報を取得
      if user && user.authenticated?(cookies[:remember_token]) #userがあって、クッキーの情報とDBのtoken情報が一致するなら
        log_in user #セッションに情報を入れて
        @current_user = user #@current_userを作る
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_usr = nil
  end

  def redirect_back_or(default) #記憶したURLまたはデフォルトへリダイレクト
    redirect_to(session[:forwarding_url] || default) #sessionに記録した場所へリダイレクト、なければデフォ
    session.delete(:forwarding_url) #記録した場所をsessionから削除
  end

  def store_location #sessionへ:for.._u..というキーでリクエストを保存
    session[:forwarding_url] = request.original_url if request.get? #request.original_urlでリクエスト先が取得できる、ただしgetリクエストのみ
  end
end