class CreateSmallScores < ActiveRecord::Migration
  def change
    create_table :small_scores do |t|
      t.integer :bh
      t.decimal :average, scale: 2, precision: 6
      t.decimal :scoring_average, scale: 2, precision: 6
      t.integer :exam_id
      t.integer :school_id
      t.string :subject_name
      t.string :grade_name

      t.timestamps
    end
  end
end
