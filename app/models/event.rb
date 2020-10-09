class Event < ApplicationRecord
    scope :sorted, lambda { order("title ASC")}
end
