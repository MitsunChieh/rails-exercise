namespace :dev do

  task :fake => :environment do
    user = User.first
    100.times do |i|
      Event.create(:name => "Event #{i}", :user => user)
    end
  end

end