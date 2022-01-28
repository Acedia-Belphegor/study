# yield => イールド

def hoge(flag)
  if flag
    yield [
      flag,
      "hoge"
    ]
  else
    yield [
      flag,
      "piyo"
    ]
  end
end

ary = []

[true, false].each do |flag|
  hoge(flag) do |result|
    ary << result
  end
end

puts ary