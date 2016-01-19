class Customer < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :sum
      t.integer :days
      t.string :email
      t.string :dni
      t.string :phone_number
      t.string :link

      t.timestamps null: false
    end
  end
end
