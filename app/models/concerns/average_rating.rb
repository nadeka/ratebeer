module AverageRating
    extend ActiveSupport::Concern

    def avg_rating
        return 0 if ratings.empty?
        (ratings.inject(0) { |sum, rating| sum + rating.score } / ratings.count.to_f).round(1)
    end
end
