Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'products#index'
  resources :products, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get 'edit_image', to: 'products#edit_image'
    end
  end
end
