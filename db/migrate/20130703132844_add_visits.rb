class AddVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :short_url_id
      t.integer :user_id
    end
  end
end
