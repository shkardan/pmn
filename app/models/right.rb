class Right < ActiveRecord::Base
  has_and_belongs_to_many :roles
  validates_presence_of :controller, :action, :name
  validates_uniqueness_of :name

  attr_accessible  :name, :controller, :action

  # Ensure that the table has one entry for each controller/action pair
  def self.synchronize
    # weird hack. otherwise ActiveRecord has no idea about the superclass of any
    # ActionController stuff...
    #require RAILS_ROOT + "/app/controllers/application"

    # Load all the controller files
    #controller_files = Dir[RAILS_ROOT + "/app/controllers/**/*_controller.rb"]

    # we need to load all the controllers...
    #controller_files.each do |file_name|
      #require file_name  # if /_controller.rb$/ =~ file_name
    #end

    # Find the actions in each of the controllers, and add them to the database
    subclasses_of(ApplicationController).each do |controller|
      controller.public_instance_methods(false).each do |action|
        #next if action =~ /return_to_main|component_update|component/
        if find_all_by_controller_and_action(controller.controller_path, action).empty?
          self.new(:name => "#{controller}.#{action}", :controller => controller.controller_path, :action => action).save!
          #self.create(:name => "#{controller}.#{action}", :controller => controller.controller_path, :action => action)
          logger.info "added: #{controller} - #{controller.controller_path}, #{action}"
        end
      end
      # The following thanks to Tom Styles
      # Then check to make sure that all the rights for that controller in the database
      # still exist in the controller itself
      self.find(:all, :conditions => ['controller = ?', controller.controller_path]).each do |right_to_go|
        unless controller.public_instance_methods(false).include?(right_to_go.action)
          right_to_go.destroy
        end
      end

    end    
    
  end

end
