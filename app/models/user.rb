class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #Rubularを使って、上記の正規表現で通るメールアドレスを確認してみる。
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false } #大文字小文字を区別しない(false)に設定する　このオプションには通常のuniquenessはtrueと判断する。
    before_save { email.downcase! }#オブジェクトが保存される前に、インスタンス変数(email)自身に、小文字のemailの値を代入。
end