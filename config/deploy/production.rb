server 'http://ec2-3-139-183-120.us-east-2.compute.amazonaws.com/', user: 'connect', roles: %w{app db web}
set :ssh_options, keys: '/Users/yoshinori/.ssh/id_rsa'