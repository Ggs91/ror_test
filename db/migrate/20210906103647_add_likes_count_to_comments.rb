class AddLikesCountToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :likes_count, :integer, default: 0, null: false
  end
end
