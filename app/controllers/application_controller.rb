class ApplicationController < ActionController::Base

	before_action :authenticate_user!, except: [:not_found, :internal_server_error]

  rescue_from CanCan::AccessDenied do |exception|
    render "pages/403", :layout => !request.xhr?
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}" if Rails.env.development?
  end

  def not_found
    render "not_found", :layout => !request.xhr?
  end

  def internal_server_error
    render "internal_server_error", :layout => !request.xhr?
  end


end
