class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :price_per_hour, :integer
    add_column :users, :description, :text
    add_column :users, :petwalker, :boolean
    add_column :users, :phone_number, :string
    add_column :users, :region, :string
    add_column :users, :city, :string
  end
end
