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
    if @event.eventpass == params[:event_pass]
      @participation.save
      redirect_to new_participation_path, :flash => { message: "Successfully signed in "}
    else
      redirect_to new_participation_path, :flash => { message: "Incorrect password" }
    end
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_id, :event_pass)
  end
end
