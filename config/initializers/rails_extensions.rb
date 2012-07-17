require 'rails_extensions/game_update'

ActionController::Base.class_eval do
  include ActionControllerExtra::GameUpdate
end