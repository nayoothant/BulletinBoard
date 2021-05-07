class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false, unique: true
      t.text :password, null: false
      t.string :profile, null: false, limit: 255
      t.string :role, limit: 1
      t.string :phone
      t.string :address
      t.date :dob
      t.integer :create_user_id, null: false
      t.integer :updated_user_id, null: false
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
