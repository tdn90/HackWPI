Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get "/dashboard", to: "dashboard#index"

  get '/receipts/:id', to: "receipts#index"

  get '/receipts/:id/edit', to: "receipts#edit"

  post '/receipts/create', to: "receipts#createReceipt"

  get '/api/v1/listgroup', to: "group#getGroupOfUser"

  delete '/api/v1/delgroup/:id', to: "group#delGroup" #incomplete  
 
  post '/api/v1/receiptPhotoTranscribe', to: 'photo#upload'  

  post '/group/create', to: 'group#createGroup'

  post '/group/add', to: 'group#addUser'
  # need item id + groupID
  post '/group/attachGroupWithItem', to: 'group#attachGroupWithItem'

  post '/receipts/delete', to: 'receipts#deleteReceipt'

  post 'group/leave', to: 'group#leaveGroup'

  post 'group/kick', to: 'group#kickGroup'

  get '/dashboard/approvals', to: 'dashboard#approval'

  post '/dashboard/approvals/approve/:id', to: 'dashboard#approve'

  post '/dashboard/approvals/approveall', to: 'dashboard#approveAll'

  post '/dashboard/approvals/reject/:id', to: 'dashboard#reject'
  
  post '/api/v1/updateReceipt', to: 'receipts#updateReceipt'

  post '/pay_period/create', to: 'pay_period#create_pay_period'

  get '/dashboard/groups', to: 'group#index'

  get '/dashboard/groups/admin/:id', to: 'group#admin'
  
  get '/payperiod/checkApproval', to: 'pay_period#checkApproval'

  get '/dashboard/groups/info/:id', to: 'group#info'
end
