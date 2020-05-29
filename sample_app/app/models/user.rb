class User < ApplicationRecord
  before_save {self.email = email.downcase}#saveする前に小文字に変える。右辺のself.は同じモデル内なので省略できる
  validates :name, presence: true, length: {maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
              format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end