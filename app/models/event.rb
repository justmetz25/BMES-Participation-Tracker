# frozen_string_literal: true

class Event < ApplicationRecord

  scope :sorted, -> { order('starttime ASC') }

  def as_json(*)
    { id: id, name: title, start_time: starttime }
  end
has_many :participation, :dependent => :destroy
#   before_destroy :remove_participation_from_event

# private

# def remove_participation_from_event
#   Event.where(id: id).update_all(id: nil)  
# end 
end
