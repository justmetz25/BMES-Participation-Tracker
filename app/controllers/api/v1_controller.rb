module Api
    class V1Controller < ActionController::API

        def events
            @events = Event.all
            render json: @events
        end

        def event
            @event = Event.find(params[:id])
            #render json: @event
            render json: {
              id: @event.id,
              name: @event.title,
              start_time: @event.starttime,
              attendees: Participation.where(event_id: @event.id)
            }
        end
        
    end
end
