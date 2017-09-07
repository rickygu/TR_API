Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :campaigns do
    collection do
      get 'ordered_campaigns'
    end
  end

end
