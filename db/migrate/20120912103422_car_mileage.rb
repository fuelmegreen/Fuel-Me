class car_mileage < ActiveRecord::Migration
  def change
    create_table(:car_mileage) do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.string :line
      t.string :manufacturer_name
      t.string :manufacturer_code
      t.integer :model_index
      t.integer :cylinders
      t.string :engine_displacement
      t.string :
      t.string :
      t.string :



    end

    add_index :car_mileage, :user_id
  end
end
