class Post < ApplicationRecord
    belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
    belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
  
    validates :title, presence: true
    validates :description, presence: true
end
