class Post < ApplicationRecord
    belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
    belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
  
    validates :title, presence: true
    validates :description, presence: true

    def self.to_csv
        attributes = Constants::HEADER    
        CSV.generate(headers: true) do |csv|
          csv << attributes    
          all.each do |post|
            csv << attributes.map{ |attr| post.send(attr) }
          end
        end
    end

    def self.import(file,create_user_id,updated_user_id)        
        CSV.foreach(file.path, headers: true,encoding:'iso-8859-1:utf-8',:quote_char => "|", header_converters: :symbol) do |row|            
            Post.create! row.to_hash.merge(create_user_id: create_user_id, updated_user_id: updated_user_id)
        end
    end
end
