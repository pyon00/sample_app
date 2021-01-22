module SessionsHelper

 # 渡されたユーザーでログインする
 def log_in(user)                                                              # login_inメソッドにuser(ログイン時にユーザーが送ったメールとパス)を引数として渡す
    session[:user_id] = user.id                                                 # ユーザーidをsessionのuser_idに代入（ログインidの保持）
  end

  # 現在ログイン中のユーザーを返す(いる場合)
  def current_user
    if session[:user_id]                                                        # ログインユーザーがいればtrue処理
      @current_user ||= User.find_by(id: session[:user_id])                     # ログインユーザーがいればそのまま、いなければcookiesのユーザーidと同じidを持つユーザーをDBから探して@current_user（現在のログインユーザー）に代入
    end
  end

  # ユーザーがログインしていればtrue、それ以外ならfalse
  def logged_in?
    !current_user.nil?                                                          # current_user(ログインユーザー)がnilじゃないならtrue、それ以外ならfalseを返す
  end

  end