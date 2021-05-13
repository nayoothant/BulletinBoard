class ProfileForm
    include ActiveModel::Model

    attr_accessor :id, :name, :email, :role, :phone, :dob, :address, :profile, :new_profile, :updated_user_id
    validates :id, :name, presence: true
    validates :email, presence: true, length: { maximum: 255},
                        format: { with: Constants::VALID_EMAIL_REGEX }
    class << self
        def initialize(params, new_profile)
            {
                :id => params.id,
                :name => params.name,
                :email => params.email,
                :role => params.role,
                :phone => params.phone,
                :dob => params.dob,
                :address => params.address,
                :profile => params.profile,
                :updated_user_id => params.updated_user_id,
                :profile => params.profile,
                :new_profile => new_profile
            }
        end        
    end
end