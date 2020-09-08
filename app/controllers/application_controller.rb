class ApplicationController < ActionController::Base
  before_action :basic
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    if @current_user.nil?
      flash[:notice] = t('ログインが必要です')
      redirect_to new_session_path
    end
  end
  
  private
  def basic
    if Rails.env == "production"
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end
end
