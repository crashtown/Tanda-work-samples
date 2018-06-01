Rails.application.routes.draw do
  resources :epoches

  post '/clear_data', to: "devices#clear_data", as: :clear_data
  post '/:device_id(/:date)', to: "devices#create_device", as: :create_device

  get  '/all', to: "devices#get_all", as: :get_all
  get  '/devices', to: "devices#get_device_only", as: :get_device_only
  get  '/:device_id(/:date)', to: "devices#get_device", as: :get_device
  get  '/:device_id/:from/:to', to: "devices#get_device_from_to", as: :get_device_from_to

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
