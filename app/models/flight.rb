require 'date'
class Flight < ApplicationRecord
    has_many :seats, dependent: :destroy
    validates :date, presence: true, comparison: { greater_than: DateTime.now }
    validates :time, presence: true
    validates :origin, presence: true
    validates :destiny, presence: true
end
