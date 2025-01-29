class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :status
      t.string :photo
      t.text :body
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
