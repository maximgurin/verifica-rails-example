class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.boolean :draft, null: false, default: true
      t.references :distribution_setting, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :read_allow_sids, null: false, array: true, default: [], index: true
      t.string :read_deny_sids, null: false, array: true, default: [], index: true

      t.timestamps
    end
  end
end
