class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by username: params[:username]

        if user and !user.provider and user.authenticate(params[:password])
            if user.active
                log_in(user) and return
            else
                redirect_to :back, notice: "Your account is frozen, please contact admin." and return
            end
        end

        redirect_to :back, notice: "Invalid username or password."
    end

    def destroy
        reset_session
        redirect_to login_path, :notice => 'Logged out!'
    end

    def create_oauth
        auth = request.env["omniauth.auth"]
        user = User.find_by(uid: auth['uid'])

        if user
            log_in(user) and return
        else
            if User.exists?(username: auth['info']['nickname'])
                redirect_to :back, notice: "Username is already taken." and return
            else
                user = User.create_with_auth(auth)
                log_in(user)
            end
        end
    end

    def log_in(user)
        reset_session
        session[:user_id] = user.id
        redirect_to user, :notice => "Logged in!"
    end
end
