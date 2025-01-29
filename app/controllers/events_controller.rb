class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_community
  before_action :set_event, only: [:show, :edit, :update, :destroy] # Add :update here

  def index
    @events = Event.all
    @events = @community.events
  end

  def new
    @event = @community.events.new
  end

  def create
    @event = @community.events.new(event_params)
    if @event.save
      redirect_to community_events_path(@community), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit
    # @event is already set by the `set_event` callback
  end

  def update
    if @event.update(event_params)
      redirect_to community_events_path(@community), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to community_events_path(@community), notice: 'Event was successfully deleted.'
  end

  def show
    # @event is already set by the `set_event` callback
    @event_dates = @community.events.pluck(:date).map { |date| date.strftime('%Y-%m-%d') } # Format as 'YYYY-MM-DD'
  end


  private

  # Finds the parent community using the community_id parameter
  def set_community
    @community = Community.find(params[:community_id])
  end

  # Finds the event within the parent community
  def set_event
    @event = @community.events.find(params[:id])
  end

  # Whitelist event parameters
  def event_params
    params.require(:event).permit(:event_name, :description, :date, :time, :place, :profile_picture, :photo)
  end
end
