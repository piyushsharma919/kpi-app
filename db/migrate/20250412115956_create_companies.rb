class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false, index: true
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.string :slug, null: false, index: { unique: true }
      t.string :website
      t.string :logo_url
      t.boolean :active, default: true, null: false
      t.jsonb :settings, default: {}
      t.timestamps
    end

    add_index :companies, :settings, using: :gin
  end
end
