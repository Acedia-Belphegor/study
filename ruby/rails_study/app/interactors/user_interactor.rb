class UserInteractor
  include Interactor

  def call
    user = User.find(context.user_id)
    puts user.name
  end
end