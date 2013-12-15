class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.integer :exam_id
      t.integer :school_id
      t.integer :user_id
      t.string :file
      t.string :file_name
      t.string :subject_name
      t.string :group_name

      t.timestamps
    end
  end
end
