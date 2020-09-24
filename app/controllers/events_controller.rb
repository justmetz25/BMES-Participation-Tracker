require 'securerandom'

class EventsController < ApplicationController
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
    @count = Participation.where("\"#{@event.uuid}\" = true")
  end

  def homepage
    @events = Event.sorted
  end

  def destroy
    @event = Event.find(params[:id])
    ActiveRecord::Migration.remove_column :participations, "#{@event.uuid}", :boolean
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
    @event.uuid = SecureRandom.uuid.gsub("-", "")
    ActiveRecord::Migration.add_column :participations, "#{@event.uuid}", :boolean, :null => false, :default => false

    if @event.save
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
