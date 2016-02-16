require 'rails_helper'

describe "Places" do
    it "if one is returned by the API, it is shown on the page" do
        allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
          [ Place.new( name:"Oljenkorsi", id: 1 ) ]
        )

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button "Search"

        expect(page).to have_content "Oljenkorsi"
    end

    it "if many are returned by the API, they are shown on the page" do
        allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
          [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Paikka", id: 2 ) ]
        )

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button "Search"

        expect(page).to have_content "Oljenkorsi"
        expect(page).to have_content "Paikka"
    end

    it "if none are returned by the API, an error notice is shown on the page" do
        allow(BeerMappingApi).to receive(:places_in).with("kumpula").and_return(
          []
        )

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button "Search"

        expect(page).to have_content "No places found in kumpula."
    end
end
