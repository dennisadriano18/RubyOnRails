class Player < ApplicationRecord
  validates :name,:score,:time_entry, presence: true
end
