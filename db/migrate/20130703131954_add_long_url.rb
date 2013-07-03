class AddLongUrl < ActiveRecord::Migration
  def change
    create_table :long_urls do |t|
      t.string :url
      t.integer :user_id
    end
  end
end
