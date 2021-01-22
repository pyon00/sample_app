require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "login with invalid information" do                                      # ログインフォームで空のデータを送り、エラーのフラッシュメッセージが描画され、別ページに飛んでflashが空であるかテスト
    get login_path                                                              # ログインURL(/login)のnewアクションを取得
    assert_template 'sessions/new'                                              # sessions/new(ログインフォームのビュー)が描画されていればtrue
    post login_path, params: { session: { email: "", password: "" } }           # ログインURL(/login)のcreateアクションへデータを送り、paramsでsessionハッシュを受け取る
    assert_template 'sessions/new'                                              # sessions/new（ログインフォームのビュー）が描画されていればtrue
    assert_not flash.empty?                                                     # flashが空ならfalse、あればtrue    
    get root_path                                                               # Homeページを取得
    assert flash.empty?                                                         # flashが空であればtrue
  end
end