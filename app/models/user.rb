class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true , length: {minimum: 5, maximum: 50},
               uniqueness: { case_sensitive: false }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

    validates :email, presence: true , length: {minimum:8,maximum:250},
               uniqueness: { case_sensitive: false },
               format: {with: VALID_EMAIL_REGEX}

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                     BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end
