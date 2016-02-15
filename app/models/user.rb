class User < ActiveRecord::Base
    include AverageRating

    has_secure_password

    validates :username, uniqueness: true, length: 3..15
    validates :password, length: 4..30

    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, -> { uniq }, through: :memberships

    def to_s
        "#{self.username}"
    end

    def favorite_beer
        return nil if ratings.empty?

        ratings.order(score: :desc).limit(1).first.beer
    end

    def favorite_style
        return nil if ratings.empty?

        rated = ratings.map{ |r| r.beer.style }.uniq
        rated.sort_by { |style| -rating_of_style(style) }.first
    end

    def favorite_brewery
        return nil if ratings.empty?

        rated = ratings.map{ |r| r.beer.brewery }.uniq
        rated.sort_by { |brewery| -rating_of_brewery(brewery) }.first
    end

    private

    def rating_of_style(style)
        ratings_of = ratings.select{ |r| r.beer.style==style }
        ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
    end

    def rating_of_brewery(brewery)
        ratings_of = ratings.select{ |r| r.beer.brewery==brewery }
        ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
    end
end
