class UserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    UserInteractor.call(user_id: user_id)
  end
end