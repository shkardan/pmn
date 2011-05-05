# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base  
  helper :all # include all helpers, all the time

  #Facebook Connect
  #before_filter :set_facebook_session
  #helper_method :facebook_session

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '24a924ba30b5bf3b25e29f4d585a5022'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  #before_filter :logged_in?
  before_filter :authorized?

  private

 def logged_in?

   unless @user = User.find_by_id(session[:user_id]) #|| local_request?
     flash[:notice] = "You must log in first!"
     redirect_to :controller => "users", :action => "home"
     return false
   end
      
 end # end of logged_in?

 def authorized?
  @user = User.find_by_id(session[:user_id])
  unless @user and (@user.roles.find_by_name('superadmin') or @user.roles.detect{ |role|
    role.rights.detect{ |right|
      (right.action == action_name && right.controller == controller_name)
      }
    })
    flash[:notice] = "You are not authorized to view the page requested. You must login first!"
    request.env["HTTP_REFERER"] ? (redirect_to :back)  : (redirect_to root_url)
    return false
  end
 end

end
