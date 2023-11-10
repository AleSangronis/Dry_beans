class RoutesController < ApplicationController 



    def index
        @rutas = Route.all.includes(trips: :orders)

        result=@rutas.map do |route|
            {
                id:route.id,
                code:route.code,
                name:route.name,
                trips:route.trips.map do |trip|
                    {
                        id:trip.id,
                        code:trip.code,
                        name:trip.name,
                        orders:trip.orders.map do |order|
                            {
                                code:order.code,
                                address:order.address,
                                order_type:order.order_type
                            }
                        end
                    }
                end
            }
        end
        

    render json: {routes:result}
        
      end


    def new_route
        routes=params_route
        @error={
            success: false,
            response:[],
        }
        if not routes.blank?
            routes=routes.each do |route|
                if !route.empty?
                Route.find_or_create_by(route)
                else
                    @error[:response] << {
                        message: "Invalid route",
                        route:route}
                end
    
            end
            if @error[:response].blank?
            render json:{success: true, routes: routes}
            else
                render json:{ error: @error}, status: :bad_request
            end
        else
            render json:{ routes:routes}, status: :bad_request
        end

    end

    private
    def params_route
        routes=nil
        if not params[:routes].blank?
            routes=params[:routes].map do |route|
                route.permit(:code, :name)
            end
        end
        routes
        
    end



end