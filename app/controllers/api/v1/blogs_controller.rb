module Api        
    module V1
        class BlogsController < Api::V1::Application_Controller
            def create
                # STEP 1: define results
                result = Blogs::Operations.new_blog(params, @current_user)
                # STEP 2: return error response if result was unsuccessful
                render_error(errors: result.errors.all, status: 400) and return unless result.sucess?
                # STEP 3: if results was successful
                # define a payload
                payload = {
                    blog: result.payload,
                    status: 201
                }
                # STEP 4: return successful response 
                render_success(payload: payload)
            end
        end
    end
end
