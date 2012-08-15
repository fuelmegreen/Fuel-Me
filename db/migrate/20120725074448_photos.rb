class Photos < ActiveRecord::Migration
  def change
    create_table(:photos) do |t|
      t.belongs_to :user
      t.string :name, limit: 64, null: false
      t.string :description
      t.string :image
    end

    add_index :photos, :user_id
  end
end
