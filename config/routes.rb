Decider::Engine.routes.draw do
  resources :workflows, only: [:new]
end
