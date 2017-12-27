Rails.application.routes.draw do
  get '/calculate', to: 'calculator#calculate'
  
  root 'calculator#calculate'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
