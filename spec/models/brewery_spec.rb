require 'rails_helper'

RSpec.describe Brewery, type: :model do
    it "is not saved without a name" do
        brewery = Brewery.create year:1927

        expect(brewery).to_not be_valid
        expect(Brewery.count).to eq(0)
    end

    it "is not saved without a year" do
        brewery = Brewery.create name:"brewery"

        expect(brewery).to_not be_valid
        expect(Brewery.count).to eq(0)
    end

    describe "with a name and a year" do
        let(:brewery){ Brewery.create name:"brewery", year:1927 }
        let!(:beer){ Beer.create name:"beer", brewery_id:brewery.id }

        it "is saved" do
            expect(brewery.name).to eq("brewery")
            expect(brewery.year).to eq(1927)

            expect(brewery).to be_valid
            expect(Brewery.count).to eq(1)
        end

        it "and with two ratings, has the correct average rating" do
            Rating.create score:10, beer_id:beer.id
            Rating.create score:20, beer_id:beer.id

            expect(brewery.ratings.count).to eq(2)
            expect(brewery.avg_rating).to eq(15.0)
        end
    end
end
