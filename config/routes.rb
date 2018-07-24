Decider::Engine.routes.draw do
  resources :workflows, only: [:new, :create] do
    collection do
      get :all_operations
    end
  end

  get  'master_workflows/index'         => 'master_workflows#index'
  get  'master_workflows/show'          => 'master_workflows#show'
  post 'master_workflows/create'        => 'master_workflows#create'
  post 'master_workflows/add_operation' => 'master_workflows#add_operation'

  get 'master_operations/show'    => 'master_operations#show'
  post 'master_operations/create' => 'master_operations#create'
  get 'master_operations/edit'    => 'master_operations#edit'
  post 'master_operations/update' => 'master_operations#update'
end
