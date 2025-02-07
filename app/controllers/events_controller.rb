class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attend, :leave]
  before_action :authorize_community_member, only: [:new, :create]
  before_action :authorize_event_owner, only: [:edit, :update, :destroy]

  def index
    @events = Event.all
    @events = Event.includes(:attendees).all
    @event = Event.find(params[:event_id]) if params[:event_id]
    # Filter events by the selected month
    if params[:month].present?
      @events = Event.where('extract(month from date) = ?', Date::MONTHNAMES.index(params[:month]))
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
    # Only show the list of attendees to the event creator
    if @event.user == current_user
      @attendees = @event.attendees
    else
      @attendees = []
    end
  end

  def new
    @event = current_user.community.events.build
  end

  def create
    @event = current_user.community.events.build(event_params)

    @event.user = current_user  # Assign event creator

    if @event.save
      redirect_to @event, notice: "Event created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted successfully!"
  end

  # Mark a user as attending an event
  def attend
    # Add current user to the event's attendees if not already added
    unless current_user.attended_events.include?(@event)
      current_user.attended_events << @event
    end
    redirect_to events_path, notice: "You are now attending the event!"
  end

  # Mark a user as leaving an event
  def leave
    current_user.attended_events.delete(@event)
    redirect_to events_path, notice: "You have left the event!"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date, :time, :place, :photo)
  end

  def authorize_community_member
    unless current_user.community
      redirect_to root_path, alert: "Only community members can create events."
    end
  end

  def authorize_event_owner
    unless @event.user == current_user
      redirect_to events_path, alert: "You can only edit or delete your own events."
    end
  end
end
