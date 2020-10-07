class ParticipationsController < ApplicationController

  # belongs_to: EventsController

  def new
    @participation = Participation.new
  end

  def create
    @participation = Participation.new(participation_params)
    redirect_to events_path, :flash => { message: "Successfully signed in"}
    # @event_id = params[:participation]
    # @event_idd = @event_id.event_idd 
    # abort @event_idd.inspect
    # @event = Event.find(@event_id) rescue nil
    # puts @event.nil?
    # if @event.nil?
    #   redirect_to new_participation_path, :flash => { message: @event_id , :event_id => @event_id}
    # else 
    #   if @event.eventpass == params[:event_pass]
    #     @participation = Participation.new(participation_params)
    #     @participation.save
    #     redirect_to new_participation_path, :flash => { message: "Successfully signed in" , :event_id => @event_id}
    #   else
    #     redirect_to new_participation_path, :flash => { message: "Incorrect password" , :event_id => @event_id}
    #   end
    # end
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_pass, :event_id)
  end
end
