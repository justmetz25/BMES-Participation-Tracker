module Api
    class V1Controller < ActionController::API

        def events
            @events = Event.all
            render json: @events
        end

        def event
            @event = Event.find(params[:id])
            render json: @event
        end
    end
end