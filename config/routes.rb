UciScheduler::Application.routes.draw do

  

  resources :searches


  get "contact", to: 'pages#contact', as: :contact

  # get 'schedule/:term_code/:ccodes', to: 'schedules#show', as: :schedule
  scope 'schedule/:term_code/:ccodes' do
   get '', to: 'schedules#show', as: :schedule
   get 'check', to: 'schedules#check', as: :check_schedule
  end



  root to: 'pages#index'
end
