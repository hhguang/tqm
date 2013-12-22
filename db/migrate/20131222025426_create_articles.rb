class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer	:exam_id
      t.string	:subject_name

      t.timestamps
    end
  end
end
