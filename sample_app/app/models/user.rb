class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {self.email = email.downcase}#saveする前に小文字に変える。右辺のself.は同じモデル内なので省略できる
  validates :name, presence: true, length: {maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
              format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def self.digest(string) # 渡された文字列のハッシュ値を返す(パスワード用暗号化) ※1
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                            BCrypt::Engine.cost # 3項演算子
    BCrypt::Password.create(string, cost: cost)
  end
  
  def self.new_token # ランダムなトークンを返す(記憶トークン用暗号化) ※1
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token # ※2　　　　　　self　　　　　　※1はクラス、※2はモデル
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token) # 渡されたを返す　　このremember_tokenはcookiesから渡されたもの
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end