class ApplicationController < ActionController::API
 serialization_scope :current_user

  # To simplify the test, I'm using the first user in database
  def current_user
    User.first
  end
end
