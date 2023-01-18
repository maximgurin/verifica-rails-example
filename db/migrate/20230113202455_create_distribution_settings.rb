class CreateDistributionSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :distribution_settings do |t|
      t.string :name, null: false
      t.string :mode, null: false
      t.string :allow_countries, null: false, array: true, default: []
      t.string :deny_countries, null: false, array: true, default: []
      t.references :owner, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
