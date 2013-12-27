class AddConformedToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :grade,	:string
    add_column :reports, :confirmed, :boolean,default: false
    add_column :users,	 :subjects,	 :text
  end
end
