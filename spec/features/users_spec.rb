require 'rails_helper'

include Helpers

describe "User" do
    let!(:user) { FactoryGirl.create :user }

    describe "who has registered" do
        describe "with right credentials" do
            before :each do
                log_in(username: 'Kate', password: 'Secret1')
            end

            it "can log in" do
                expect(page).to have_content 'Logged in!'
                expect(page).to have_content 'Kate'
            end

            describe "with ratings" do
                before :each do
                    brewery = Brewery.create name:"brewery", year:1847
                    style = FactoryGirl.create(:style)
                    create_beers_with_ratings(user, style, brewery,  20)
                    visit user_path(user)
                end

                it "can see their own ratings" do
                    expect(page).to have_content "#{user.ratings.count}"
                    expect(page).to have_content "#{user.avg_rating}"

                    user.ratings.each do |rating|
                        expect(page).to have_content rating.beer.name
                        expect(page).to have_content rating.score
                    end
                end

                it "can remove their rating" do
                    expect {
                        click_on('Delete')
                    }.to change{Rating.count}.by(-1)
                end
            end
        end

        it "is redirected back to login form if wrong credentials given" do
            log_in(username: 'Kate', password: 'wrong')

            expect(current_path).to eq(login_path)
            expect(page).to have_content 'Invalid username or password.'
        end
    end

    it "who registers with good credentials is added to the system" do
        visit register_path
        fill_in('user_username', with:'Brian')
        fill_in('user_password', with:'Secret2')
        fill_in('user_password_confirmation', with:'Secret2')

        expect {
            click_button('Create User')
        }.to change{User.count}.by(1)
    end
end
