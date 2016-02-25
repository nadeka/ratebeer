class SessionsController < ApplicationController

    def new
    end

    def create
        reset_session
        user = User.find_by username: params[:username]

        if user.nil?
            redirect_to :back, notice: "User #{params[:username]} does not exist!"
        elsif not user.authenticate(params[:password])
            redirect_to :back, notice: "Incorrect password."
        elsif not user.active
            redirect_to :back, notice: "Your account is frozen, please contact admin."
        else
            session[:user_id] = user.id if not user.nil?

            redirect_to user, notice: "Welcome back!"
        end
    end

    def destroy
        session[:user_id] = nil

        redirect_to login_path
    end
end
