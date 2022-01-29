require 'net/http'
require 'nokogiri'
require 'csv'

result = []

for idx in 1..47 do
  prefecture = format("%02d", idx)
  uri = URI.parse("https://www.orca.med.or.jp/receipt/chihoukouhi/p#{prefecture}/")
  response = Net::HTTP.get_response(uri)  
  html = Nokogiri::HTML.parse(response.body, nil, 'utf-8')
  
  html.xpath('html/body/div[@id="wrapper"]/div[@id="content"]/div[@id="mainContent"]/table/tbody')[2].xpath('tr').each do |tr|
    th = tr.xpath('th').text
    if th.to_i.positive?
      td1 = tr.xpath('td')[1].text
      td2 = tr.xpath('td')[2].text
      result << [prefecture, th, td1, td2]
    end
  end
end

CSV.open("result.csv", 'w', :encoding => 'utf-8') do |csv|
  result.each do |row|
    csv << row
  end
end
