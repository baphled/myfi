MyFi::Application.routes.draw do
  resources :transactions
  resources :incomes, :only => [:create]
  resources :outgoings, :only => [:create]
  resources :financial_breakdown, :only => [:index]
end
