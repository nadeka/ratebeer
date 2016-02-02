class Brewery < ActiveRecord::Base
    include AverageRating

    validates :name, length: { minimum: 1 }
    validates :year, numericality: { greater_than_or_equal_to: 1042,
                                     less_than_or_equal_to: promise { Time.now.year },
                                     only_integer: true }

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers
end
