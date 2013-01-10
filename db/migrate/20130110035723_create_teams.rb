class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.string :name

      t.timestamps
    end

    add_index :teams, :user1_id
    add_index :teams, :user2_id
  end
end
