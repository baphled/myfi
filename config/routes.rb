MyFi::Application.routes.draw do
  resources :transactions
  resources :incomes, :only => [:create]
  resources :outgoings, :only => [:create]
  resources :financial_breakdown, :only => [:index]
  resource :session, :only => [:new, :create, :destroy]
end
