class AddShortUrl < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :url
      t.integer :long_url_id
    end
  end
end
