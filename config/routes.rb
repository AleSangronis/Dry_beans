Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'routes', to:'routes#index'
  post 'routes', to:'routes#new_route'
  get 'trips', to:'trips#index'
  post 'trips', to:'trips#new_trips'
  get 'trips/:route_id' , to:'trips#route_id'


  get 'orders', to:'orders#index'
  post 'orders', to:'orders#create'
  put 'orders' , to:'orders#update_orders'

end
