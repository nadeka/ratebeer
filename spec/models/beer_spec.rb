require 'rails_helper'

RSpec.describe Beer, type: :model do
    it "is not saved without a name" do
        beer = Beer.create

        expect(beer).to_not be_valid
        expect(Beer.count).to eq(0)
    end

    describe "with a name and a style" do
        let(:style){ Style.create name:"lager", description:"description" }
        let(:beer){ Beer.create name:"beer", style_id:style.id }

        it "is saved" do
            expect(beer.name).to eq("beer")
            expect(beer.style).to eq(style)

            expect(beer).to be_valid
            expect(Beer.count).to eq(1)
        end

        it "and with two ratings, has the correct average rating" do
            rating = Rating.new score:10
            rating2 = Rating.new score:20

            beer.ratings << rating
            beer.ratings << rating2

            expect(beer.ratings.count).to eq(2)
            expect(beer.avg_rating).to eq(15.0)
        end
    end
end
