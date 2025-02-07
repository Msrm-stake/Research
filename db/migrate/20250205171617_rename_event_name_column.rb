class RenameEventNameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :event_name, :name
  end
end
