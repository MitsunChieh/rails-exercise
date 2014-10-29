class AddUserIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :user, :integer
  end
end
