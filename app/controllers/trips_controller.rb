class TripsController < ApplicationController
    def index
        trips=Trip.all
        render json: {trips:trips}
        end
      
        def new_trips
          trips=trips_params
          @errors={
            success: false,
            response:[]
          }
          if  not trips.blank?
            trip=trips.each do |trip|
            if trip[:route_id]
              begin
              route=Route.try(:find, trip[:route_id])
              rescue
                   @errors[:response] << {
                  message: "Invalid route_id",
                  trips:trip}
               end
              if !route.blank? && @errors[:response].blank?
                @trips=Trip.new(trip)
                route.trips << @trips
              end
            else
              @errors[:response] << {
                message: "Invalid route_id",
                trips:trip}
            end
            end
            if @errors[:response].blank?
               render json: {
                 trips: trips
                }
              else
                render json:{error: @errors}, status: :bad_request
              end
           else
          render json: {
          success: false
         }
        end
        end
      
        def route_id
          trips=Trip.where(route_id:params[:route_id])
          render json:trips
        end
      
        private
        def trips_params
          trips = nil
          if params[:trips].present?
          trips = params.require(:trips).map do |trip|
            trip.permit(:code, :name, :route_id )
          end
        end
        trips
      end
end
