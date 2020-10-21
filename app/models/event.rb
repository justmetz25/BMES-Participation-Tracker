# frozen_string_literal: true

class Event < ApplicationRecord
  scope :sorted, -> { order('title ASC') }

  def as_json(options={})
    {id: id, name: title, start_time: starttime}
  end
end

