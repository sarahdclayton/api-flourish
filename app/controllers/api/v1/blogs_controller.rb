module Api        
    module V1
        class BlogsController < Api::V1::ApplicationController
            skip_before_action :authenticate, only: %i[home show update]
            def index 
                # refering to a response
                blogs = Blog.all 
                # render json: blogs, status: :ok 
                payload = {
                    blogs: BlogBlueprint.render_as_hash(blogs),
                    status: 200
                }
                render_success(payload: payload)
            end

            def show 
                blog = Blog.find(params[:id])
                render json: BlogBlueprint.render_as_hash(blog), status: :ok 
            end

            def create
                # STEP 1: define results
                result = Blogs::Operations.new_blog(params, @current_user)
                # STEP 2: return error response if result was unsuccessful
                render_error(errors: result.errors.all, status: 400) and return unless result.success?
                # STEP 3: if results was successful
                # define a payload
                payload = {
                    blog: BlogBlueprint.render_as_hash(result.payload),
                    # blog: result.payload,
                    status: 201
                }
                # STEP 4: return successful response 
                render_success(payload: payload)
            end

            def destroy
                blog = Blog.find(params[:id])
                blog.destroy
                render json: {message: "Blog Deleted"}, status: :ok 
            end

            def home
                render_success(payload: {suggested: BlogBlueprint.render_as_hash(Blog.order("RANDOM()").limit(5)), categories: Category.all})
            end

            def update
                blog = Blog.find(params[:id])

                if blog.update(title: params[:title], content: params[:content], sub_title: params[:sub_title], image_path: params[:image_path])
                    # render json: blog, status: :ok 
                    payload = {
                        blog: BlogBlueprint.render_as_hash(blog),
                        # blog: result.payload,
                        status: 201
                    }
                    # STEP 4: return successful response 
                    render_success(payload: payload)
                else
                    render_error(errors: blog.errors.full_messages, status: 400)
                end
            end
             
            def blog_params
                params.require(:blog).permit(:title, :sub_title, :content, :image_path, category_id:[])
            end
        end
    end
end
