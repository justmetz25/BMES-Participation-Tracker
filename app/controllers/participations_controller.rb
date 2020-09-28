class ParticipationsController < ApplicationController

  # belongs_to: EventsController

  def new
    @participation = Participation.new
  end

  def create
    @event_id = params[:event_id]
    @event = Event.find(params[:event_id]) rescue nil
    puts @event.nil?
    if @event.nil?
      redirect_to new_participation_path, :flash => { message: "No such event associated with id" }
    else 
      if @event.eventpass == params[:event_pass]
        @participation = Participation.new(participation_params)
        @participation.save
        redirect_to new_participation_path, :flash => { message: "Successfully signed in" }
      else
        redirect_to new_participation_path, :flash => { message: "Incorrect password" }
      end
    end
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_pass).merge(event_id: @event.id)
  end
end
