class CommentUpdate < ActiveRecord::Migration
  def change
    remove_column :comments, :visit_id
  end
end
