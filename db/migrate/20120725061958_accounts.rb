class Accounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.belongs_to :user
      t.string :provider, :limit => 64, :null => false
      t.string :uid,                    :null => false
      t.string :username, :limit => 64
      t.string :avatar, :email, :token, :secret
      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :provider
    add_index :accounts, :uid
    add_index :accounts, :username
    add_index :accounts, :email
  end
end
