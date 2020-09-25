class ParticipationsController < ApplicationController

  def new
    @participation = Participation.new
  end

  def create
    @participation = Participation.new
    @event_id = params[:event_id]
    @event = Event.find(params[:event_id]) rescue nil
    puts @event.nil?
    if @event.nil?
      redirect_to new_participation_path, :flash => { message: "No such event associated with id" }
    else 
      if @event.eventpass == params[:event_pass]
        # https://stackoverflow.com/questions/52847334/adding-dynamic-attributes-to-a-rails-model ???
        @participation.instance_eval { class << self; self end }.send(:attr_accessor, "#{@event.title.gsub(" ", "_")}_#{@event.id}")
        # https://stackoverflow.com/questions/16530532/rails-4-insert-attribute-into-params
        @participation = Participation.new(participation_params.merge("#{@event.title.gsub(" ", "_")}_#{@event.id}": true))
        # @participation.send("#{@event.title.gsub(" ", "_")}_#{@event.id}=", true)

        @participation.save
        redirect_to new_participation_path, :flash => { message: "Successfully signed in" }
      else
        redirect_to new_participation_path, :flash => { message: "Incorrect password" }
      end
    end
  end

  def participation_params
    params.require(:participation).permit(:uin, :first_name, :last_name, :email, :event_id, :event_pass)
  end
end
