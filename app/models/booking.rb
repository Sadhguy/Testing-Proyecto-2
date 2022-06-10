class Booking < ApplicationRecord
    serialize :seats, Array
    validates :user, presence: true
end
