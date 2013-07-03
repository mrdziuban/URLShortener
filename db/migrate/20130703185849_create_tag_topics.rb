class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag
      t.integer :short_url_id
    end
  end
end
