class RatingsController < ApplicationController
    before_action :expire_stats, only: [:create, :edit, :update, :destroy]
    before_action :skip_if_cached, only: [:index]

    def index
        @ratings = Rating.includes(:beer, :user).all
        @recent = Rating.includes(:beer, :user).recent(5)
        @top_breweries = Brewery.top(3)
        @top_beers = Beer.top(3)
        @top_styles = Style.top(3)
        @top_raters = User.top_raters(5)
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

    private

    def expire_stats
        expire_fragment('ratings')
    end

    def skip_if_cached
        return render :index if fragment_exist?('ratings') and request.format.html?
    end
end
