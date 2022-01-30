require 'elasticsearch' # gem install elasticsearch -v '<=7.10.0' (インストールされているelasticsearchのバージョンと合わせる)

def client
  @client ||= Elasticsearch::Client.new({ log: true, url: 'localhost:9200' })
end

def init
  client.indices.delete(index: 'japanese')
  client.indices.create(index: 'japanese')
  
  client.create({index: 'japanese', type: 'books', id: 1, body: { title: '吾輩は猫である', text: '吾輩は猫である。名前はまだ無い。どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。'}})
  client.create({index: 'japanese', type: 'books', id: 2, body: { title: '学問のすゝめ', text: '「天は人の上に人を造らず人の下に人を造らず」と言えり。されば天より人を生ずるには、万人は万人みな同じ位にして、生まれながら貴賤上下の差別なく、万物の霊たる身と心との働きをもって天地の間にあるよろずの物を資り、もって衣食住の用を達し、自由自在、互いに人の妨げをなさずしておのおの安楽にこの世を渡らしめ給うの趣意なり。'}})
  client.create({index: 'japanese', type: 'books', id: 3, body: { title: '蜘蛛の糸', text: 'ある日の事でございます。御釈迦様は極楽の蓮池のふちを、独りでぶらぶら御歩きになっていらっしゃいました。池の中に咲いている蓮の花は、みんな玉のようにまっ白で、そのまん中にある金色の蕊からは、何とも云えない好い匂が、絶間なくあたりへ溢れて居ります。極楽は丁度朝なのでございましょう。'}})  
end

def search
  # response = client.search(index: 'japanese')
  # response = client.search(index: 'japanese', type: 'books')
  # response = client.search(index: 'japanese', type: 'books', body: {query: {match: {text: '極楽'}}})
  response = client.search(index: 'japanese', body: {query: {query_string: {default_field: 'text', query: '極楽'}}})
  puts "結果"
  puts response
end
