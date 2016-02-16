class PlacesController < ApplicationController
    def index
    end

    def show
        @place = Rails.cache.read(session['city']).detect{|place| place.id == params[:id]}
        render :show
    end

    def search
        @places = BeerMappingApi.places_in(params[:city])
        session['city'] = params[:city]

        if @places.empty?
            redirect_to places_path, :notice => "No places found in #{params[:city]}."
        else
            render :index
        end
    end
end
