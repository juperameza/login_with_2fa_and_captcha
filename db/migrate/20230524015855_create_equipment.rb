class CreateEquipment < ActiveRecord::Migration[7.0]
  def change
    create_table :equipment do |t|
      t.boolean :free_weigth
      t.string :name
      t.integer :status
      t.timestamps
    end
  end
end
