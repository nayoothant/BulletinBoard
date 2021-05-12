class PostForm
    include ActiveModel::Model

    validates :title, :description, presence: true
    attr_accessor :id, :title, :description, :status, :updated_user_id
    class << self
        def initialize(params)
            {
                :id => params.id,
                :title => params.title,
                :description => params.description,
                :status => params.status,
                :updated_user_id => params.updated_user_id
            }
        end        
    end
end