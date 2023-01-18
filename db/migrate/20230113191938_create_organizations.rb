class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :allow_countries, null: false, array: true, default: []
      t.string :deny_countries, null: false, array: true, default: []

      t.timestamps
    end
  end
end
