class Import < ActiveRecord::Migration

  def change
  	create_table "order_items", :force => true do |t|
    t.integer  "paper_order_id"
    t.integer  "school_id"
    t.string   "school_name"
    t.integer  "g1yw",           :default => 0
    t.integer  "g1sx",           :default => 0
    t.integer  "g1yy",           :default => 0
    t.integer  "g1wl",           :default => 0
    t.integer  "g1hx",           :default => 0
    t.integer  "g1sw",           :default => 0
    t.integer  "g1zz",           :default => 0
    t.integer  "g1ls",           :default => 0
    t.integer  "g1dl",           :default => 0
    t.integer  "g2w",            :default => 0
    t.integer  "g2l",            :default => 0
    t.integer  "g2yw",           :default => 0
    t.integer  "g2sxl",          :default => 0
    t.integer  "g2sxw",          :default => 0
    t.integer  "g2yy",           :default => 0
    t.integer  "g2wl",           :default => 0
    t.integer  "g2hx",           :default => 0
    t.integer  "g2sw",           :default => 0
    t.integer  "g2zz",           :default => 0
    t.integer  "g2ls",           :default => 0
    t.integer  "g2dl",           :default => 0
    t.integer  "g3w",            :default => 0
    t.integer  "g3l",            :default => 0
    t.integer  "g3yw",           :default => 0
    t.integer  "g3sxl",          :default => 0
    t.integer  "g3sxw",          :default => 0
    t.integer  "g3yy",           :default => 0
    t.integer  "g3wz",           :default => 0
    t.integer  "g3lz",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",      :default => false
    t.string   "handler"
    t.string   "telephone"
  end

  create_table "paper_orders", :force => true do |t|
    t.string   "name"
    t.integer  "item_type"
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qxes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "qx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_files", :force => true do |t|
    t.string   "filename"
    t.string   "disk_filename"
    t.integer  "filesize"
    t.string   "content_type"
    t.integer  "digest"
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "exam_id"
    t.boolean  "confirmed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "f_type"
  end


  # create_table "users", :force => true do |t|
    add_column :users, "login",   :string,                  :limit => 40
    
    add_column :users,    "crypted_password",    :string,      :limit => 40
    add_column :users,    "salt",         :string,             :limit => 40
    
    add_column :users,    "remember_token",   :string  ,	       :limit => 40
    add_column :users,  "remember_token_expires_at",:datetime
    add_column :users,   "school_id",:integer
    add_column :users,   "is_admin",     :boolean,                            :default => false
    add_column :users,   "qx_id",:integer
    add_column :users,   "telephone",:string
  # end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  end
end
