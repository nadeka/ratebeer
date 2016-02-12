class RatingsController < ApplicationController
    def index
        @ratings = Rating.all
    end

    def new
        @rating = Rating.new
        @beers = Beer.all
    end

    def create
        @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

        if current_user.nil?
            redirect_to login_path, notice: 'You should be logged in.'
        end

        respond_to do |format|
          if @rating.save
            current_user.ratings << @rating
            format.html { redirect_to current_user, notice: 'Rating was successfully created.' }
            format.json { render :show, status: :created, location: @rating }
          else
            @beers = Beer.all
            format.html { render :new }
            format.json { render json: @rating.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        rating = Rating.find params[:id]
        rating.delete if rating.user == current_user
        redirect_to :back
    end
end
