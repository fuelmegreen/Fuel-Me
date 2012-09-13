class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.string :name
      t.string :email
      t.text :body
      t.string :url
      t.string :ip
      t.string :user_agent
      t.string :referrer
      t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :email
  end
end
