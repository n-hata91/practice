class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
  render html: 'Hi, toy_app'

  protect_from_forgery with: :exception
end
