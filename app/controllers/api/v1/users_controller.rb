# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: [:create, :login]

      def login
        # STEP 1: get results
        result = BaseApi::Auth.login(params[:email], params[:password], @ip)

        # STEP 2: return error response if result was unsuccessful
        render_error(errors: 'User not authenticated', status: 401) and return unless result.success?

        # STEP 3: if results was successful
        # define a payload
        payload = {
          user: UserBlueprint.render_as_hash(result.payload[:user], view: :login),
          token: TokenBlueprint.render_as_hash(result.payload[:token]),
          status: 200
        }
        # STEP 4: return successful response
        render_success(payload: payload, status: 200)
      end

      def logout
        result = BaseApi::Auth.logout(@current_user, @token)
        render_error(errors: 'There was a problem logging out', status: 401) and return unless result.success?

        render_success(payload: 'You have been logged out', status: 200)
      end

      def create
        # user = User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], phone: params[:phone], password: params[:password])
        # if user.save 
        #   render json: {success: true, user: user, status: 201}
        # else
        #   render json: {errors: "There was a problem creating a new user", status: 400}
        # end
        
        # STEP 1: get the result from the service 
        result = BaseApi::Users.new_user(params)
        # Step 2: return an error if the results was unsuccessful
        render_error(errors: 'There was a problem creating a new user', status: 400) and return unless result.success?
        # Step 3: otherwise, build a payload
        payload = {
          user: UserBlueprint.render_as_hash(result.payload, view: :normal)
        }
        # Step 4: return a successful response attached with the payload
        render_success(payload: payload, status: 201)
      end

      def me
        render_success(payload: UserBlueprint.render_as_hash(@current_user), status: 200)
      end

      def validate_invitation
        user = User.invite_token_is(params[:invitation_token]).invite_not_expired.first

        render_error(errors: { validated: false, status: 401 }) and return if user.nil?
        render_success(payload: { validated: true, status: 200 })
      end
    end
  end
end
