require 'interactor' # gem install interactor

class PiyoInteractor
  include Interactor

  before do
    puts "before"
  end

  after do
    puts "after"
  end

  def call
    puts "call"

    puts "code => #{context.code}"
    puts "name => #{context.name}"

    if !context.flag
      context.fail!(error: "flag is false")
    end
  end
end

hash = {code: "123456", name: "ほげ", flag: true}
result = PiyoInteractor.call(hash)
puts "success? => #{result.success?}"

hash = {code: "999999", name: "ぴよ", flag: false}
result = PiyoInteractor.call(hash)
puts "success? => #{result.success?}"

if result.failure?
  puts "error => #{result.error}"
end