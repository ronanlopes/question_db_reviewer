
#Using find_or_create so it won't raise a error in case role already exists
["Administrator", "Client"].each do |role|
	Role.find_or_create_by(name: role)
end