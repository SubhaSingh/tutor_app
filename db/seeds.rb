User.create!(name:  "Example User",
             email: "example@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             superadmin: false,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Example Newuser",
             email: "examplenew@railstutorial.org",
             password:              "foobarnew",
             password_confirmation: "foobarnew",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

#Creating courses
Course.create!( name: "Dummy")

Course.create!( name: "Newdummy")

30.times do |n|
  name    = Faker::Name.first_name
     
  Course.create!(name:  name)
end

#Creating convenors for courses
20.times do |n|
  user    = "#{n+1}"
  course  = "#{n+1}"
  Convenor.create!( course_id: course,
                            user_id: user)
end

10.times do |n|
  user    = "#{n+1}"
  course  = "#{n+21}"
  Convenor.create!( course_id: course,
                            user_id: user)
end

#Creating tutors for courses
10.times do |n|
  user    = "#{n+11}"
  course  = "#{n+1}"
  tutor = Tutor.create!( course_id: course,
                  user_id: user)
end

10.times do |n|
  user    = "#{n+1}"
  course  = "#{n+21}"
  tutor = Tutor.create!( course_id: course,
                  user_id: user)
end

10.times do |n|
  user    = "#{n+1}"
  course  = "#{n+11}"
  tutor = Tutor.create!( course_id: course,
                  user_id: user)
end

#Creating lecturers for courses
10.times do |n|
  user    = "#{n+31}"
  course  = "#{n+1}"
  lecturer = Lecturer.create!(  course_id: course,
                      user_id: user)
end

Lecturer.create!( course_id: 2, user_id: 1)

#Creating Tutor_information for courses
20.times do |n|
  course  = "#{n+1}"
  content = "Testing. . . "
  user = "#{n+1}"
  TutorInformation.create!(  course_id: course,
                              content: content, user_id: user)
end


#Creating Availabilites for courses
30.times do |n|
  course  = "#{n+1}"
  Availability.create!(course_id: course)
end



#Create Posts for courses
Post.create!(course_id: 1, content: "Lorem Ipsum. . .", user_id: 1)
Post.create!(course_id: 1, content: "Lorem Ipsum. . .", user_id: 1)
Post.create!(course_id: 1, content: "Blah. . .", user_id: 11)
Post.create!(course_id: 1, content: "Blah Blah. . .", user_id: 31)

30.times do 
  Post.create!(course_id: 1, content: "Lorem Ipsum. . .", user_id: 1)
end 

#Create invites

Invite.create!(email: "example@gmail.com", course_id: 1)

