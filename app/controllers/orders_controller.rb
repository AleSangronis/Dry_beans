class OrdersController < ApplicationController

    def index
        @orders=Order.all
        render json:{
            success: true,
            orders: @orders
        }
    end

    def create
        orders=params_orders
        @error={
            success: false,
            response:[],
        }
        if not orders.blank?
            orders_=orders.each do |order|
                if(order[:trip_id])
                begin
                trip=Trip.try(:find, order[:trip_id])
                rescue
                    @error[:response] << {
                        message: "Invalid trip_id",
                        order:order}
                end
                if !trip.blank? && @error[:response].blank?
                    orden=trip.orders.find_by(code: order[:code])
                    if orden.blank?
                    trip.orders.new(order)
                    trip.save   
                    else
                        @error[:response] <<   {
                            message: "Orden ya existe en el trip",
                            order:order}
                    end
                end
                else
                Order.new(order).save
                end
            end
            if @error[:response].blank?
            render json:{success: true, orders: orders_}
            else
                render json:{error: @error}, status: :bad_request
            end
            else
            render json:{ success: false, orders: orders}, status: :bad_request
        end
    end

    def update_orders
        orders=params_orders
        @error={
            success: false,
            response:[],
        }

        if not orders.blank?
            ordersUpdate_=orders.each do |order|
                exist=Order.where(code:order[:code],trip_id: order[:trip_id])
                if not exist.blank?
                    if @error[:response].blank?
                        exist.update(order)
                    end
                else
                    @error[:response] << { message: "Orden no existe",
                    order:order
                    }
                end
            end
             if @error[:response].blank?
                render json:{success: true, orders: ordersUpdate_}
                else
                    render json:{ error: @error}, status: :bad_request
            end
        else
        render json:{success: false, orders: orders}, status: :bad_request
        end
     end
      

    
     private
    
     def params_orders
        orders=nil
        if not params[:orders].blank?
           orders=params.require(:orders).map do |order|
                order.permit(:code, :address, :trip_id, :order_type )
            end
        end
        orders
    end
end
