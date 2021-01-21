require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do                                          # 新規登録が失敗（フォーム送信が）した時用のテスト
    get signup_path                                                             # ユーザー登録ページにアクセス
    assert_no_difference 'User.count' do                                        # User.countでユーザー数が変わっていなければ（ユーザー生成失敗）true,変わっていればfalse
      post users_path, params: { user: { name: "",                              # signup_pathからusers_pathに対してpostリクエスト送信(/usersへ)、paramsでuserハッシュとその下のハッシュで値を受け取れるか確認
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
  end

  

  assert_template 'users/new'                                                   # newアクションが描画(つまり@user.save失敗)されていればtrue、なければfalse
  assert_select   'div#error_explanation'                                       # divタグの中のid error_explanationをが描画されていれば成功
  assert_select   'div.field_with_errors'                                       # divタグの中のclass field_with_errorsが描画されていれば成功
  
  
end
end