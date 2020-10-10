class Event < ApplicationRecord
  scope :sorted, -> { order('title ASC') }
end
