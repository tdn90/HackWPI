Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get "/dashboard", to: "dashboard#index"

  get '/receipts/:id', to: "receipts#index"

  get '/group', to: "group#getGroupOfUser"
 
  post '/api/v1/receiptPhotoTranscribe', to: 'photo#upload'  

end
