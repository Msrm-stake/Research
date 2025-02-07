class EventAttendeesController < ApplicationController
  before_action :set_event

  def index
    @attendees = @event.attendees
  end

  def create
    @event.attendees << current_user unless @event.attendees.include?(current_user)
    redirect_to @event, notice: "You are now attending this event."
  end

  def destroy
    @event.attendees.delete(current_user)
    redirect_to @event, notice: "You have left this event."
  end


  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end