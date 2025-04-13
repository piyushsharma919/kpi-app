class CreateCompanyRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :company_roles do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
