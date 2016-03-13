class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    helper_method :current_user
    helper_method :ensure_that_admin
    helper_method :sort_column, :sort_direction

    def current_user
        return nil if session[:user_id].nil?
        User.find(session[:user_id])
    end

    def ensure_that_logged_in
        redirect_to login_path, notice:'You should be logged in.' if !current_user
    end

    def ensure_that_admin
        current_user and current_user.admin
    end

    def sort_column(acceptable_columns, default)
        acceptable_columns.include?(params[:sort]) ? params[:sort] : default
    end

    def sort_direction
       %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
