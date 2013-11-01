class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.boolean :closed
      t.text :brief
      t.integer :user_id
      t.integer :qx_id
      t.string :exam_type
      t.timestamps
    end
  end
end
