set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server 'psrails.ugent.be', user: 'deploy', roles: %w{web app}
