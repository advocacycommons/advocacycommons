class EventsController < ApplicationController
  before_action :authenticate_person!
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: JsonApi::EventsRepresenter.for_collection.new(Event.add_attendance_counts(@events)).to_json
      end
    end
  end
end
