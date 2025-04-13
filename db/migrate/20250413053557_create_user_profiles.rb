class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :bio
      t.string :location
      t.string :website

      t.timestamps
    end

    # add_index :user_profiles, :user_id, unique: true
  end
end
