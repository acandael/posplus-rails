set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '95.85.5.6', user: 'deploy', roles: %w{web app}
