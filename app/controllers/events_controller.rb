class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @events = Event.all()
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params.require(:event).permit(:name,:instructions))
    @event.save
    render 'show', status: 201
  end

  def update
    event = Event.find(params[:id])
    event.update_attributes(params.require(:event).permit(:name,:instructions))
    head :no_content
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    head :no_content
  end
end
