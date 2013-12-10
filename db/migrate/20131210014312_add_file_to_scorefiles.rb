class AddFileToScorefiles < ActiveRecord::Migration
  def change
    add_column :score_files, :file, :string
    add_column :exams,:upload_started,:boolean,:default=>false
  end
end
