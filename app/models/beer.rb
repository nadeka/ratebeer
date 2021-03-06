class Beer < ActiveRecord::Base
    include AverageRating
    extend Top

    validates :name, length: { minimum: 1 }

    belongs_to :brewery, touch: true
    belongs_to :style
    has_many :ratings, dependent: :destroy
    has_many :raters, -> { uniq }, through: :ratings, source: :user

    def to_s
        "#{self.name}, #{self.brewery.name}"
    end
end
