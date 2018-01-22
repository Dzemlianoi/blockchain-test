Rails.application.routes.draw do
  post 'add_data', to: 'blockchain#add_data'
  get 'last_blocks/:quantity', to: 'blockchain#last_blocks'
end
