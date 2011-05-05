namespace :db do
  
  desc 'sets the roles and rights for the admin and user'
  task :rbac => :environment do

    #create the basic roles
    ['superadmin', 'admin', 'user'].each { |r| Role.create(:name => r) }

    #create the admin user
    User.new( :username => 'superadmin', :password => 'pass20', :primarynumber => '0000' ).add_account_save

    #create the admin role and assign all the rights to it
    User.find_by_username('superadmin').roles << Role.find_by_name('superadmin')

    #add all the rights to the admin role
    #Right.synchronize
    #Right.find(:all).each { |right| Role.find_by_name('superadmin').rights << right }
    
  end
end