require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'csv'

titles = []

url = 'https://job.rikunabi.com/2021/s/?j=22&j=24&isc=ps054&pn=4'

charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end



doc = Nokogiri::HTML.parse(html, nil, charset)
doc.xpath('//div[@class="ts-h-search-cassetteTitle"]').each do |node|
  title = node.search('a').text
  titles.push(title)
end

CSV.open("company_title.csv", "w") do |csv|
  csv << titles
end