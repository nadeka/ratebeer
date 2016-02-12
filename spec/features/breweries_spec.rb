require 'rails_helper'

describe "Brewery" do
    it "should have zero breweries at first" do
        visit breweries_path
        expect(page).to have_content 'Breweries'
        expect(page).to have_content '0 breweries'
    end

    describe "when breweries exists" do
        before :each do
            @breweries = ["Koff", "Karjala", "Schlenkerla"]
            year = 1896

            @breweries.each do |brewery_name|
                FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
            end

            visit breweries_path
        end

        it "lists existing breweries and their total number" do
            expect(page).to have_content "#{@breweries.count} breweries"

            @breweries.each do |brewery_name|
                expect(page).to have_content brewery_name
            end
        end

        it "allows user to navigate to a page of a brewery" do
             click_link "Koff"

             expect(page).to have_content "Koff"
             expect(page).to have_content "Established in 1897"
        end
    end
end
