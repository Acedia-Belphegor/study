require 'interactor'

class HogeInteractor
  include Interactor

  def call
    case context.calc_type
    when "plus"
      context.result = context.values.sum
    else
      context.fail!(errors: "invalid calc_type params. #{calc_type}")
    end
  end
end

puts HogeInteractor.call(calc_type: "plus", values: [1, 2, 3]).result
__END__

https://applis.io/posts/rails-design-pattern-interactor-objects
https://qiita.com/verdy89/items/00a2992a9a62cacec00e
