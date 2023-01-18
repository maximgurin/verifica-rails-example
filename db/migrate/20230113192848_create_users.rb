class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :description, null: false, default: ""
      t.string :country, null: false
      t.string :role, null: false
      t.references :organization, null: true, foreign_key: true

      t.timestamps
    end
  end
end
