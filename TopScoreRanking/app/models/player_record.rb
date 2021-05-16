class PlayerRecord < ApplicationRecord
  validates :name,:score,:time_entry, presence: true
end
