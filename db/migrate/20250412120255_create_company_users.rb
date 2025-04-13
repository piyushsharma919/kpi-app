class CreateCompanyUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :company_users do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: { to_table: :companies }
      t.references :company_role, null: false, foreign_key: { to_table: :company_roles }
    end

    add_index :company_users, [ :user_id, :company_id ], unique: true
    add_index :company_users, [ :company_id, :company_role_id ]
  end
end
