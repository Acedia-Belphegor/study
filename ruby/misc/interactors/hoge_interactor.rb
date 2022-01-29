require 'interactor' # gem install interactor

class HogeInteractor
  include Interactor

  before do
    puts "before"
    context.values = [] if context.values.nil?
  end

  after do
    puts "after"
  end

  def call
    puts "call"
    case context.type
    when "sum"
      context.result = context.values.sum
    when "join"
      context.result = context.values.join
    else
      context.fail!(errors: "invalid calc_type params. #{calc_type}")
    end
  end
end

puts "sum => #{HogeInteractor.call(type: "sum", values: [1, 2, 3]).result}"
puts "join => #{HogeInteractor.call(type: "join", values: [1, 2, 3]).result}"
puts "sum => #{HogeInteractor.call(type: "sum").result}"

__END__

https://applis.io/posts/rails-design-pattern-interactor-objects
https://qiita.com/verdy89/items/00a2992a9a62cacec00e
