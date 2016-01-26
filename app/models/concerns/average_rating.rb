module AverageRating
    extend ActiveSupport::Concern

    def avg_rating
        sum = self.ratings.inject(0) { |sum, rating| sum + rating.score }
        sum / self.ratings.count
    end
end
