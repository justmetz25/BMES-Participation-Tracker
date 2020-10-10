# frozen_string_literal: true

class ParticipationsController < ApplicationController
  # belongs_to: EventsController

  def new
    @participation = Participation.new
  end

  def create
    @event_id = params['participation']['event_id']
    # abort @event_id.inspect
    # @participation = Participation.new(participation_params)
    # @participation.save
    # redirect_to events_path, :flash => { message: "Successfully signed in"}
    # @event_id = params[:participation]
    # @event_idd = @event_id.event_idd
    # abort @event_idd.inspect
    @event = begin
               Event.find(@event_id)
             rescue StandardError
               nil
             end
    puts @event.nil?
    if @event.nil?
      redirect_to new_participation_path(event_id: @event_id), flash: { message: 'No Such Event' }
    else
      if @event.eventpass == params[:event_pass]
        @participation = Participation.new(participation_params)
        @participation.save
        redirect_to events_path, flash: { message: 'Successfully signed in' }
      else
        redirect_to new_participation_path(event_id: @event_id), flash: { message: 'Incorrect password' }
      end
    end
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_pass, :event_id)
  end
end
