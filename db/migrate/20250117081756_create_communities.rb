class CreateCommunities < ActiveRecord::Migration[7.1]
  def change
    create_table :communities do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :profile_picture

      t.timestamps
    end
  end
end
