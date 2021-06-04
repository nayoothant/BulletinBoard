class User < ApplicationRecord
    before_create { generate_token(:auth_token) }

    before_save :email_downcase
    belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
    belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
    validates :name, :profile, presence: true
    validates :email, presence: true, length: { maximum: 255},
                        format: { with: Constants::VALID_EMAIL_REGEX  },
                        uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence: true,on: :create
    has_secure_password

    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver
    end
      
    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
 
    private
 
    def email_downcase
        self.email = email.downcase
    end
end
