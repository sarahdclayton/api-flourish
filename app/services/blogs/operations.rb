module Blogs
    module Operations
        def self.new_blog(params, current_user)
            blog = current_user.blogs.new(title: params[:title], content: params[:content], sub_title: params[sub_title], image_path: params[:image_path])

            return ServiceContract.success(blog) if blog.save

            ServiceContract.error(blog.errors.full_message)
        end
    end
end
