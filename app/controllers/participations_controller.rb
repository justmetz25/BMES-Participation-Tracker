class ParticipationsController < ApplicationController

  def new
    @participation = Participation.new
  end

  def create
    @participation = Participation.new(participation_params)
    puts "EVENT ID #{params[:event_id]}"
    @event_id = params[:event_id]
    @event = Event.find(@event_id)
    @participation.send("#{@event.uuid}=", true)
    @participation.save
    render("new")
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_id)
  end
end
