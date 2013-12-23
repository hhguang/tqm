class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :exam, index: true

      t.timestamps
    end
  end
end
