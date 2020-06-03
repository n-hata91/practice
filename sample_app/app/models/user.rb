class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email # =={email.downcase!}
  before_create :create_activation_digest
  validates :name, presence: true, length: {maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
              format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

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

  def authenticated?(attribute, token) #渡されたtokenがdigestと一致するかどうか　sendメソッドで抽象化されてsessionとactivateで使用できる
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
#---activation---
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
#---reset---
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end