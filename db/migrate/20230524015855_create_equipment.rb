class CreateEquipment < ActiveRecord::Migration[7.0]
  def change
    create_table :equipment do |t|
      t.string :free_weigth
      t.string :boolean,
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
