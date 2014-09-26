class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy #保证用户的微博在删除用户的同时也会被删除
  #这两个字断不能为空，name长度不能超过50，email格式验证
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false } #Rails 会自动指定 :uniqueness 的值为 true
  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_create :create_remember_token

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end