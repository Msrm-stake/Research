class AddGroupToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :group, :string
  end
end
