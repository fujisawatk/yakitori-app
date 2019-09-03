server '3.114.117.13', user: 'fuji', roles: %w{app db web}
set :ssh_options, keys: '~/.ssh/yakitori_key_rsa' 