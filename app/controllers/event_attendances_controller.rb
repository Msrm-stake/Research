class EventAttendancesController < ApplicationController
  before_action :set_event

  def create
    if @event.event_attendances.exists?(user: current_user)
      redirect_to @event, alert: 'You are already attending this event.'
    else
      @event.event_attendances.create(user: current_user)
      redirect_to @event, notice: 'You are now attending this event.'
    end
  end

  def destroy
    attendance = @event.event_attendances.find_by(user: current_user)
    if attendance
      attendance.destroy
      redirect_to @event, notice: 'You are no longer attending this event.'
    else
      redirect_to @event, alert: 'You were not attending this event.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
