class AddImagePathToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :image_path, :string
  end
end
