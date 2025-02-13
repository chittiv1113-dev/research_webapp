# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
## db/seeds.rb

# db/seeds.rb

# Create users FIRST
admin_user = User.create!(email: 'davidvanderklay@tamu.edu', name: 'Admin User', provider: 'google_oauth2', uid: '123') # Use a real UID in a real app
faculty_user = User.create!(email: 'davidvanderklay@gmail.com', name: 'Faculty User', provider: 'google_oauth2', uid: '456') # Use a real UID in a real app
student_user = User.create!(email: 'georgelantin@gmail.com', name: 'Student User', provider: 'google_oauth2', uid: '789') # Use a real UID in a real app

# THEN create the associated roles
admin_user.create_admin!
faculty_user.create_faculty!(department: "CSCE")
student_user.create_student!(year: 2024, major: "Computer Science") # Example student data
# Add projects later

# You'll need to create projects, etc., later.
