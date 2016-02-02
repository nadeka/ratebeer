class User < ActiveRecord::Base
    include AverageRating

    has_secure_password

    validates :username, uniqueness: true, length: 3..15
    validates :password, length: 4..30
    validates :password, format: { with: /(?=.*\d)(?=.*[A-Z])/,
               message: "must contain one uppercase letter and one digit" }

    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, -> { uniq }, through: :memberships

    def to_s
        "#{self.username}"
    end
end
