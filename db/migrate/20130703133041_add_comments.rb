class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :visit_id
      t.integer :short_url_id
    end
  end
end
