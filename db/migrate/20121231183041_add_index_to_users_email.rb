class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :employee_id, unique: true
    add_index :users, :name,        unique: true
  end
end
