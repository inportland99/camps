Camps::Application.routes.draw do

  resources :camp_interests

  resources :weekly_programs

  resources :camp_surveys do
    collection { post :import }
  end

  resources :coupon_codes

  devise_for :users, :skip => [:registrations]
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
    end

  resources :locations


  resources :camp_offerings do
    collection { post :import }
  end

  resources :camps do
    collection do
      get :descriptions
      post :import
    end
  end

  resources :registrations do
    collection { get :total_discounts }
  end


  root :to => 'pages#home'

  get '/faq', to: 'pages#faq'
  get '/reg_confirmation', to: 'pages#reg_confirmation'
  get '/comparison', to: 'pages#comparison'
  get '/email_confirmation', to: 'registrations#email_confirmation'
  get '/thank_you', to: 'pages#thank_you'
  get '/testimonials', to: 'pages#testimonials'
  post 'coupon_codes/code_lookup', to: 'coupon_codes#code_lookup'
  post 'camp_offerings/week_at_a_glance', to: 'camp_offerings#week_at_a_glance'
  get 'camp_surveys/contacted/:id', to: 'camp_surveys#contacted'
end
