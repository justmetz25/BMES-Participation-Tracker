# frozen_string_literal: true

class Event < ApplicationRecord
  scope :sorted, -> { order('title ASC') }
end
