class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :community, null: false, foreign_key: true
      t.string :community_profile_picture
      t.string :event_name
      t.text :description
      t.date :date
      t.time :time
      t.string :place

      t.timestamps
    end
  end
end
