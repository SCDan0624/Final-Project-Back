class AuthController < ApplicationController 
    skip_before_action :authorized, only: [:create]
    def create
        # byebug
        user = User.find_by(name: params[:name])
          # Bcrypt gives us the authenticate method, Do no call password_digest.
        if user && user.authenticate(params[:password]) 
          my_token = issue_token(user)
    
          render json: {id: user.id, name: user.name, token: my_token}
        else
          render json: {error: 'Invalid username or password'}, status: 401
        end
    end
    
    def show
        render json: { id: current_user.id, name: current_user.name }
     end

end