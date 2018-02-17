role :app, %w[blockchain@35.178.40.81]
role :web, %w[blockchain@35.178.40.81]
role :db,  %w[blockchain@35.178.40.81]

set :branch, 'master'
set :rails_env, 'production'
set :puma_env, :production

server '35.178.40.81', user: 'blockchain', roles: %w[web app]
