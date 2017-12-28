set :application, 'myquot_staging'
set :stage, :staging
set :rails_env, :staging
set :deploy_to, '/home/deploy/myquot_staging'
set :release_note_url, 'http://staging.myquot.com/release_note.txt'

server '52.221.37.206', user: 'deploy', roles: %w{web app db job}
