require 'rails_helper'

describe "Beer" do
    it "should have zero beers at first" do
        visit beers_path
        expect(page).to have_content 'Beers'
        expect(page).to have_content '0 beers'
    end

    describe "when beers exists" do
        before :each do
            @beers = ["Karhu", "Tuplahumala", "Lite"]

            @beers.each do |beer_name|
                FactoryGirl.create(:beer, name: beer_name)
            end

            visit beers_path
        end

        it "lists existing beers and their total number" do
            expect(page).to have_content "#{@beers.count} beers"

            @beers.each do |beer_name|
                expect(page).to have_content beer_name
            end
        end

        it "allows user to navigate to a page of a beer" do
             click_link "Karhu"

             expect(page).to have_content "Karhu"
             expect(page).to have_content "Style: lager"
        end
    end

    describe "when created" do
        before :each do
            FactoryGirl.create(:user)
            log_in(username: 'Kate', password: 'Secret1')
            visit beers_path
        end

        it "is saved if the name is valid" do
            FactoryGirl.create(:brewery, name:"Koff", year:1938)
            FactoryGirl.create(:style)
            visit new_beer_path

            fill_in('beer_name', with:'Lite')
            select('lager', from:'beer[style_id]')
            select('Koff', from:'beer[brewery_id]')

            expect{
                click_button "Create Beer"
            }.to change{Beer.count}.from(0).to(1)

            expect(page).to have_content "Beer was successfully created."
        end

        it "is not saved if the name is invalid" do
            FactoryGirl.create(:brewery, name:"Koff", year:1938)
            FactoryGirl.create(:style)
            visit new_beer_path

            select('lager', from:'beer[style_id]')
            select('Koff', from:'beer[brewery_id]')

            click_button "Create Beer"

            expect(Beer.count).to eq(0)
            expect(page).to have_content "error"
            expect(page).to have_content "Name is too short (minimum is 1 character)"
        end
    end
end
