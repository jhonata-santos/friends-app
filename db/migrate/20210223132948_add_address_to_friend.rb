class AddAddressToFriend < ActiveRecord::Migration[6.1]
  def change
    add_column :friends, :city, :string
    add_column :friends, :state, :string
    add_column :friends, :postal_code, :string
  end
end
