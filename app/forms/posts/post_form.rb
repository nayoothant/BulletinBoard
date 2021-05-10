class PostForm
    include ActiveModel::Model

    validates :title, :description, presence: true

    class << self
        
    end
end