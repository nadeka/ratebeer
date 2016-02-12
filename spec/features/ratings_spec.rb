require 'rails_helper'

include Helpers

describe "Rating" do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryGirl.create :beer, name:"Iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
    let!(:user) { FactoryGirl.create :user }

    before :each do
        log_in(username: 'Kate', password: 'Secret1')
    end

    it "should have zero ratings at first" do
        visit ratings_path
        expect(page).to have_content 'Ratings'
        expect(page).to have_content '0 ratings'
    end

    describe "when ratings exists" do
        before :each do
            @ratings = [10, 20, 30, 0, 100]

            create_beers_with_ratings(user, *@ratings)

            visit ratings_path
        end

        it "lists existing ratings and their total number" do
            expect(page).to have_content "#{@ratings.count} ratings"

            ratings = Rating.all

            ratings.each do |rating|
                expect(page).to have_content rating.score
                expect(page).to have_content rating.user.username
                expect(page).to have_content rating.beer.name
            end
        end
    end

    it "when created, is registered to the beer and user who is signed in" do
        visit new_rating_path
        select('Iso 3', from:'rating[beer_id]')
        fill_in('rating[score]', with:'15')

        expect{
            click_button "Create Rating"
        }.to change{Rating.count}.from(0).to(1)

        expect(user.ratings.count).to eq(1)
        expect(beer1.ratings.count).to eq(1)
        expect(beer1.avg_rating).to eq(15.0)
    end
end
