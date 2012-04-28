namespace :db do

  desc "Fill databse with sample users and posts"

  task :populate => :environment do
    User.create!(
      :name => "SampleUser",
      :email => "sampleuser@example.com",
      :password => "foobar12345",
      :password_confirmation => "foobar12345")
    99.times do |n|
      name = Faker::Name.name.delete(" ").delete(".").delete("'")
      email = "example#{n+1}@example.com"
      password = "foobar12345"
      User.create!(
        :name => name,
        :email => email,
        :password => password,
        :password_confirmation => password)
    end

    users = User.all(:limit => 10)
    5.times do
      title = Faker::Lorem.sentence(5)
      body = Faker::Lorem.sentence(20)
      users.each { |user| user.posts.create!(:title => title, :body => body) }
    end
  end
end
