Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get "/dashboard", to: "dashboard#index"

  get '/receipts/:id', to: "receipts#index"

  post '/receipts/create', to: "receipts#createReceipt"

  get '/api/v1/listgroup', to: "group#getGroupOfUser"

  delete '/api/v1/delgroup/:id', to: "group#delGroup" #incomplete  
 
  post '/api/v1/receiptPhotoTranscribe', to: 'photo#upload'  

  post '/group/create', to: 'group#createGroup'

  # need item id + groupID
  post '/group/attachGroupWithItem', to: 'group#attachGroupWithItem'

  post '/group/add', to: 'group#addUsers'

  post '/group/leave', to: 'group#leaveGroup'
end
