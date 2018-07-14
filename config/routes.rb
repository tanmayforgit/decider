Decider::Engine.routes.draw do
  resources :workflows, only: [:new, :create] do
    collection do
      get :all_operations
    end
  end
end
