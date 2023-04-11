class BlogBlueprint < Blueprinter::Base
    identifier :id
    fields :title, :content, :image_path, :user, :created_at, :sub_title, :categories 
  end
  