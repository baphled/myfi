MyFi::Application.routes.draw do
  resources :transactions
  resources :incomes, :only => [:create]
  resources :outgoings, :only => [:create]
end
