class User < ApplicationRecord
    before_save :email_downcase
    belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
    belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
    validates :name, :profile, :address, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence: true,on: :create
    has_secure_password
 
    private
 
    def email_downcase
        self.email = email.downcase
    end

    def self.types
        types = {
            'Admin' => '0',
            'User' => '1'
        }
    end
end
