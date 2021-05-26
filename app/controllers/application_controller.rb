class ApplicationController < ActionController::Base
  def hello
    render html:"HELLO!"
  end
end
