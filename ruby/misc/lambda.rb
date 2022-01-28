ary =[]

hoge = lambda{ |calc_type, i| 
  case calc_type
  when "plus"
    ary << i + 1
  when "minus"
    ary << i - 1
  else
    raise ArgumentError, "invalid calc_type params. #{calc_type}"
  end
}

[0, 1, 2].each{ |i| hoge.call("plus", i) }

puts ary # [1, 2, 3]
