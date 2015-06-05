class User < ActiveRecord::Base

    attr_accessor :remember_token

    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: {case_sensitive: false}
    # Note, while edit/update with empty password, it is allowed by validation below
    # has_secure_password only enforces presence upon object creation
    has_secure_password
    validates :password, length: {minimum: 6}, allow_blank: true

    # Return the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                    : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Return a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remember the user in the database for use in persistent sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Return true if the given token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        # BCrypt::Password.new(remember_digest) == remember_token
        # the "==" above is redefined as below:
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forget a user
    def forget
        update_attribute(:remember_digest, nil)
    end
end













