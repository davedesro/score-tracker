class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :employee_id
      t.string :name
      t.string :tagline

      t.timestamps
    end
  end
end
