server '3.139.183.120', user: 'yoshinori', roles: %w{app db web}
set :ssh_options, keys: '~/.ssh/id_rsa'