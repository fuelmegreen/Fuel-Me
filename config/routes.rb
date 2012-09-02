FuelMe::Application.routes.draw do

  #mount Blog::Engine => "/blog"

  # Devise/ActiveAdmin Authentication
  devise_for :users, ActiveAdmin::Devise.config

  # Devise Auth paths
  devise_scope :user do
    get "login",    to: "devise/sessions#new"
    get "logout",   to: "devise/sessions#destroy"
    get "register", to: "devise/registrations#new"
  end 
 
  # ActiveAdmin Panel paths
  ActiveAdmin.routes(self)

  # Facebook Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure',            to: 'sessions#failure'
  match '/logout',                  to: 'sessions#destroy', :as => 'logout'
  match '/users/check',             to: 'users#check'

  # Models/Resources
  resources :users
  resources :photos

  # Public pages
  match 'how_it_works' => 'home#how_it_works', as: :how_it_works
  match 'loans'        => 'home#loans',        as: :loans
  match 'investors'    => 'home#investors',    as: :investors
  match 'calculator'   => 'home#calculator',   as: :calculator
  match 'about'        => 'home#about',        as: :about
  match 'contact'      => 'home#contact',      as: :contact
  match 'help'         => 'home#help',         as: :help
  match 'privacy'      => 'home#privacy',      as: :privacy
  match 'terms'        => 'home#terms',        as: :terms

  root :to => 'home#index'
end
