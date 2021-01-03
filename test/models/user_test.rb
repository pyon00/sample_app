require 'test_helper'

class UserTest < ActiveSupport::TestCase


  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid? #@user.valid?がtrueを返すと成功、falseを返すと失敗
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid? #@userが有効でなくなったことを確認（@userが無効なら成功、有効なら失敗）
  end

  test "email bhould be present" do
    @user.email = "     "
    assert_not @user.valid?
  end


  test "name should not be too long" do
    @user.name = "a" * 51   #51文字の"a"を@user.nameに代入
    assert_not @user.valid? #@userが有効でなくなった（nameが50文字より多い）ことを確認(@userが無効なら成功、有効なら失敗)
  end


  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com" #244文字の"a"と"@example.com"を足し合わせた文字を@user.emailに代入
    assert_not @user.valid?                 #@userが有効でなくなった（emailが255文字より多い）か確認(@userが無効なら成功、有効なら失敗)
  end

    #メールアドレスのフォーマットに対するテスト
    test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]                    #5つのアドレスを配列で指定(有効なアドレスリスト)
      valid_addresses.each do |valid_address|                                     #それぞれの要素をブロックvalid_addressに繰り返し代入。一個ずつ検証する。
        @user.email = valid_address                                               #@user.emailにブロックを代入
        assert @user.valid?, "#{valid_address.inspect} should be valid" #@userが通ったらtrue、通らなかったらfalse。さらに、第二引数でどのメールアドレスで失敗したかエラーメッセージを追加
      end
    end

    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.   
                             foo@bar_baz.com foo@bar+baz.com foo@bar..com]        #配列で５つのアドレス指定(無効のアドレスリスト)
      invalid_addresses.each do |invalid_address|                                 #それぞれの要素をブロックinvalid_addressに繰り返し代入。1つずつ検証。
        @user.email = invalid_address                                             #@user.emailにブロックを代入
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"   #@userが有効なら失敗、無効なら成功。第二引数で失敗したメールアドレスをそのまま文字列として表示
      end
    end


    test "email addresses should be unique" do
    duplicate_user = @user.dup                                                  #@userを複製する
    duplicate_user.email = @user.email.upcase                                   #複製したduplicate_userのメールアドレス欄の文字列を大文字にする
    @user.save                                                                  #@userをデータベースに保存
    assert_not duplicate_user.valid?                                            #@userの複製が有効なら失敗、無効なら成功
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email                  #第一引数で@userのEmailを小文字に変換、第二引数でDBからEmail(大文字小文字混同のemail)を再読み込み、この二つが同一であればtrueを返す
  end
  
end