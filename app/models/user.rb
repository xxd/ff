class User < ActiveRecord::Base
	#这两个字断不能为空，name长度不能超过50，email格式验证
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } #Rails 会自动指定 :uniqueness 的值为 true
    before_save { self.email = email.downcase }
    has_secure_password
    validates :password, length: { minimum: 6 }
end
