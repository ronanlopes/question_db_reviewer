# Question DB Reviewer

This is a platform where you can sign up for registering questions that must be approved or denied by the application administrators.
It was developed using Ruby(2.4.1) on Rails (5.2.0) framework.

Setup:

rails db:create 
rails db:migrate
rails db:seed

This will create the basic records required to run the application correctly (like user roles and question status). It also creates a default admin user (admin@email.com, admin123) which has permissions to review the questions created by users with the client role. Anyone can sign up with the client role auto assigned.
Administrators users may be created using rails console. The application doesn't has an user management module.
If you have any problem to run it, contact me on lopesronanufsj@gmail.com.