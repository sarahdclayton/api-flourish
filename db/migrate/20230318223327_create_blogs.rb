class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.string :sub_title
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
