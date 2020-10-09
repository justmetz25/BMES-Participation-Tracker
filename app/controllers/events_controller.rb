require 'securerandom'

class EventsController < ApplicationController

  # has_many: ParticipationsController 

  def delete
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.sorted
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    # @count = Participation.all
    @count = Participation.where(:event_id => params[:id])
    # @count = Participation.all(:condition => ["event_id == :event", { :event => params[:id]}])
  end

  def homepage
    @events = Event.sorted
  end

  def destroy
    @event = Event.find(params[:id])
    # Do not add or create new columns
    # ActiveRecord::Migration.remove_column :participations, "#{@event.title.gsub(" ", "_")}_#{@event.id}", :boolean
    @event.destroy
    flash[:notice] = "Event '#{@event.title}' destroyed successfully."
    redirect_to(events_path)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated successfully."
      redirect_to(events_path)

    else
      render('edit')
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      # Cannot add new column!!
      # ActiveRecord::Migration.add_column :participations, "#{@event.title.gsub(" ", "_")}_#{@event.id}", :boolean, :null => false, :default => false
      flash[:notice] = "Event created successfully."
      redirect_to(events_path)
    else
      render("new")
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :place, :description, :starttime, :endtime, :eventpass)
  end
end
