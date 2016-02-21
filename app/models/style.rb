class Style < ActiveRecord::Base
    include AverageRating
    extend Top

    has_many :beers
    has_many :ratings, through: :beers

    def to_s
        "#{self.name}"
    end
end
