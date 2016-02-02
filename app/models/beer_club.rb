class BeerClub < ActiveRecord::Base
    has_many :memberships, dependent: :destroy
    has_many :members, -> { uniq }, through: :memberships, source: :user, dependent: :destroy

    validates :name, length: { minimum: 1 }
    validates :city, length: { minimum: 1 }
    validates :founded, numericality: { greater_than_or_equal_to: 1042,
                                     less_than_or_equal_to: promise { Time.now.year },
                                     only_integer: true }

    def to_s
        "#{self.name}"
    end
end
