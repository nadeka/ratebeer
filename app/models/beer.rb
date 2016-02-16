class Beer < ActiveRecord::Base
    include AverageRating

    validates :name, length: { minimum: 1 }

    belongs_to :brewery
    belongs_to :style
    has_many :ratings, dependent: :destroy
    has_many :raters, -> { uniq }, through: :ratings, source: :user

    def to_s
        "#{self.name}, #{self.brewery.name}"
    end
end
