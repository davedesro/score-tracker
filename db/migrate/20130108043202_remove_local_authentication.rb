class RemoveLocalAuthentication < ActiveRecord::Migration
  def up
    remove_column :users, :name
    remove_column :users, :password_digest
    remove_column :users, :employee_id
  end

  def down
    add_column :users, :name, :string
    add_column :users, :password_digest, :string
    add_column :users, :employee_id, :integer
  end
end
