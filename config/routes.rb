Rails.application.routes.draw do

  root :to => 'some#index'

  namespace :api do
    post  'first_step'     => 'customers#first_step'
    patch 'second_step'   => 'customers#second_step'
    patch 'final_step'    => 'customers#final_step'
  end
end
