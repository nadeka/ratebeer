class User < ActiveRecord::Base
    include AverageRating

    has_secure_password

    validates :username, uniqueness: true, length: 1..15
    validates :password, length: 1..30

    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, -> { uniq }, through: :memberships

    after_initialize :set_active

    def set_active
        self.active = true if self.active.nil?
    end

    def to_s
        "#{self.username}"
    end

    def favorite_beer
        return nil if ratings.empty?

        ratings.order(score: :desc).limit(1).first.beer
    end

    def favorite_style
        favorite :style
    end

    def favorite_brewery
        favorite :brewery
    end

    private

    def favorite(category)
        return nil if ratings.empty?

        rated = ratings.map{ |r| r.beer.send(category) }.uniq
        rated.sort_by { |item| -rating_of(category, item) }.first
    end

    def rating_of(category, item)
        ratings_of = ratings.select{ |r| r.beer.send(category) == item }
        ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
    end

    def self.top_raters(n)
        User.all.sort_by { |user| -user.ratings.count }[0..n-1]
    end
end
