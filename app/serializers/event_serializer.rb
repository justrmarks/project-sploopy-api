class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :start_time, :end_time,
   :location, :google_link
        

  attribute :host do |event|
    event.host
  end

 attribute :image_src do |event|
  event.picture_file.attached? ? url_for(event.picture_file) : false
 end

 attribute :accessability do |event|
  {water: event.water, mobility: event.mobility, flashing_lights: event.flashing_lights, bathrooms: event.bathrooms}
 end

  attribute :attending do |event, params|
    event.attendees.include?(params[:current_user])
  end

  attribute :attendees, if: Proc.new { |event, params|
    if (params[:current_user])
      event.host.id == params[:current_user].id || params[:current_user].role == 'admin'
    else
      false
    end
 }
  
end
