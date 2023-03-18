class CreatedBlogsCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs_categories do |t|
      t.belongs_to :blog, null:false, foreign_key: true
      t.belongs_to :category, null:false, forigen_key: true 
    end
  end
end
