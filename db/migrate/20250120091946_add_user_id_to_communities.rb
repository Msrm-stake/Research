class AddUserIdToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :user_id, :integer
  end
end
