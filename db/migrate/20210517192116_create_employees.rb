class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.float :salary
      t.string :rating
      t.integer :manager_id
      t.string :role
      t.string :status, default: "Active"

      t.timestamps
    end

    add_foreign_key :employees, :employees, column: :manager_id
  end
end
