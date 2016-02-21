class Brewery < ActiveRecord::Base
    include AverageRating
    extend Top

    validates :name, length: { minimum: 1 }
    validates :year, numericality: { greater_than_or_equal_to: 1042,
                                     less_than_or_equal_to: promise { Time.now.year },
                                     only_integer: true }

    scope :active, -> { where active: true }
    scope :retired, -> { where active: [nil, false] }

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers
end
