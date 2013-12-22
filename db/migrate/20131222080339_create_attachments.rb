class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :file_name
      t.integer :file_size
      t.integer :article_id

      t.timestamps
    end
  end
end
