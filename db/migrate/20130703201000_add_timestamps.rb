class AddTimestamps < ActiveRecord::Migration
  def change
    add_timestamps(:users)
    add_timestamps(:long_urls)
    add_timestamps(:short_urls)
    add_timestamps(:visits)
    add_timestamps(:comments)
    add_timestamps(:tag_topics)
  end
end
