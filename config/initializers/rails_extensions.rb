require 'rails_extensions/user_logger'

ActionController::Base.class_eval do
  include ActionController::GameUpdate
end