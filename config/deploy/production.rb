set :application, 'myquot_production'
set :stage, :production
set :rails_env, :production
set :deploy_to, '/home/deploy/myquot_production'
set :release_note_url, 'http://myquot.com/release_note.txt'

server 'myquot.com', user: 'deploy', roles: %w{web app db job}
