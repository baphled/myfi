MyFi::Application.routes.draw do
  resources :transactions
  resources :incomes, :except => [:index]
  resources :outgoings, :except => [:index]
  resources :financial_breakdown, :only => [:index]
  resource :session, :only => [:new, :create, :destroy]
  resource :users
  resource :financial_dashboard, :only => [:index]

  match 'logout', :controller => 'sessions', :action => 'destroy'
  match 'login', :controller => 'sessions', :action => 'new'
  match 'dashboard', :controller => 'financial_dashboard', :action => 'index'
end
