
#Using find_or_create so it won't raise a error in case role already exists
["Administrator", "Client"].each do |role|
	Role.find_or_create_by(name: role)
end

#Can't use find_or_create_by directly 'cause there's no "password" column
user = User.find_by(name: "Administrator", email: "admin@email.com", role: Role.find_by_name("Administrator"))
if !user
	user = User.new(name: "Administrator", email: "admin@email.com", role: Role.find_by_name("Administrator"))
	user.password = "admin123"
	user.save
end

["Pending", "Approved", "Denied"].each do |question_status|
	QuestionStatus.find_or_create_by(name: question_status)
end
