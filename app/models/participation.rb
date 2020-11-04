# frozen_string_literal: true

class Participation < ApplicationRecord
  def as_json(*)
    { email: email, first_name: first_name, last_name: last_name, uin: uin }
  end
end
