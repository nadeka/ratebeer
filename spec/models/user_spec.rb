require 'rails_helper'

RSpec.describe User, type: :model do
    it "is not saved without a username" do
        user = User.create

        expect(user).not_to be_valid
        expect(User.count).to eq(0)
    end

    it "is not saved without a proper password" do
        user1 = User.create username:"Kate", password:"Ab1", password_confirmation:"Ab1"

        expect(user1).not_to be_valid
        expect(User.count).to eq(0)

        user2 = User.create username:"Tom", password:"abcd", password_confirmation:"abcd"

        expect(user2).not_to be_valid
        expect(User.count).to eq(0)

        user3 = User.create username:"Jack", password:"Abcd", password_confirmation:"Abcd"

        expect(user3).not_to be_valid
        expect(User.count).to eq(0)

        user4 = User.create username:"Paul", password:"abc1", password_confirmation:"abc1"

        expect(user4).not_to be_valid
        expect(User.count).to eq(0)

        user5 = User.create username:"Kim"

        expect(user5).not_to be_valid
        expect(User.count).to eq(0)
    end

    describe "with a username and a proper password" do
        let(:user){ FactoryGirl.create(:user) }

        it "is saved" do
            expect(user.username).to eq("Kate")
            expect(user).to be_valid
            expect(User.count).to eq(1)
        end

        describe "ratings" do
            it "with two ratings, has the correct average rating" do
                user.ratings << FactoryGirl.create(:rating)
                user.ratings << FactoryGirl.create(:rating2)

                expect(user.ratings.count).to eq(2)
                expect(user.avg_rating).to eq(15.0)
            end
        end

        describe "favorite beer" do
            it "has a method for determining one" do
                expect(user).to respond_to(:favorite_beer)
            end

            it "without ratings does not have one" do
                expect(user.favorite_beer).to eq(nil)
            end

            it "is the only rated one if only one rating" do
                beer = create_beer_with_rating(user, 25)

                expect(user.favorite_beer).to eq(beer)
            end

            it "is the one with highest rating if several rated" do
                create_beers_with_ratings(user, 10, 7, 2, 4, 24, 0)
                best = create_beer_with_rating(user, 25)

                expect(user.favorite_beer).to eq(best)
            end
        end

        describe "favorite style" do
            it "has a method for determining one" do
                expect(user).to respond_to(:favorite_style)
            end

            it "without ratings does not have one" do
                expect(user.favorite_style).to eq(nil)
            end

            it "is the only rated one if only one rating" do
                beer = create_beer_with_rating(user, 25)
                expect(user.favorite_style).to eq(beer.style)
            end

            it "is the one with highest rating if several rated" do
                create_beers_with_ratings_and_styles(user, {10 => "Porter", 7 => "IPA",
                                    2 => "Porter", 4 => "IPA", 24 => "Lager"})

                expect(user.favorite_style).to eq("Lager")
            end
        end
    end
end

def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
end

def create_beer_with_rating_and_style(user, score, style)
    beer = FactoryGirl.create(:beer, style:style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
end

def create_beers_with_ratings(user, *scores)
    scores.each do |score|
        create_beer_with_rating(user, score)
    end
end

def create_beers_with_ratings_and_styles(user, attrs)
    attrs.each do |score, style|
        create_beer_with_rating_and_style(user, score, style)
    end
end
