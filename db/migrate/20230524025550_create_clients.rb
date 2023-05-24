class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.date :birthdate
      t.boolean :membership
      t.string :emergency_cname
      t.string :emergency_cphone

      t.timestamps
    end
  end
end
