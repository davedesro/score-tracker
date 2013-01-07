class AddGoogleSupportToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_id,    :string
    add_column :users, :google_token, :string
    add_column :users, :first_name,   :string
    add_column :users, :last_name,    :string
    add_column :users, :email,        :string
    add_column :users, :google_hd,    :string
    add_column :users, :google_image_url, :string

    add_index :users, :email, unique: true
  end
end
