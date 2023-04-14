module Api        
    module V1
        class CategoriesController < Api::V1::ApplicationController
            skip_before_action :authenticate, only: %i[index]
            def index 
                categories = Category.all 
                # render json: blogs, status: :ok 
                payload = {
                    categories: categories
                }
                render_success(payload: payload)
            end
        end
    end
end
