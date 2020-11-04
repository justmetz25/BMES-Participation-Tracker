# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Event.create!(title: 'Title', place: 'Zach 310', description: 'Description') if Rails.env.development?
# Participation.create!(uin: 123, first_name: 'Joe', event_id: 1) if Rails.env.development?
Participation.create!(uin: 456, first_name: 'Joanna', event_id: 1) if Rails.env.development?

if Rails.env.test?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  Event.create!(title: 'Event Title', place: 'Event Place', description: 'Event Description',
                starttime: '2025-01-01 00:00:00', endtime: '2025-01-01 01:00:00', eventpass: '1')
end
