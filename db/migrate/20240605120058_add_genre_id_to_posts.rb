class AddGenreIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :genre_id, :integer
  end
end
