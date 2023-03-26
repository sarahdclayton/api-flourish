module Api        
    module V1
        class BlogsController < Api::V1::ApplicationController
            def index 
                # refering to a response
                blogs = Blog.all 
                render json: blogs, status: :ok 
            end

            def show 
                blog = Blog.find(params[:id])
                render json: blog, status: :ok 
            end

            def create
                # STEP 1: define results
                result = Blogs::Operations.new_blog(params, @current_user)
                # STEP 2: return error response if result was unsuccessful
                render_error(errors: result.errors.all, status: 400) and return unless result.success?
                # STEP 3: if results was successful
                # define a payload
                payload = {
                    blog: result.payload,
                    status: 201
                }
                # STEP 4: return successful response 
                render_success(payload: payload)
            end

            def destroy
                blog = Blog.find(params[:id])
                blog.destroy
                # render json: {message: "Blog Deleted"}, status: :ok 
                respond_to do |blog|
                    blog.html
                    blog.json { render json: @blogs }
                end
            end

            def update
                @blog = Blog.find(params[:id])

                if blog.update(title: params[:title], content: params[:content], sub_title: params[:subtitle], image_path: params[:image_path])
                    render json: blog, status: ok 
                else
                    render json: blog.error, status: :unprocessable_entity 
                end
            end
        end
    end
end
