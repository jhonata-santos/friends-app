class AddGenderToFriends < ActiveRecord::Migration[6.1]
  def change
    add_column :friends, :gender, :string
  end
end
