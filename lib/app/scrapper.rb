class Scrapper

  PAGE_URL = "http://www.annuaire-des-mairies.com/val-d-oise.html"

  def get_townhall_urls(page)
    townhall_urls = page.xpath('//a[contains(@class, "lientxt")]/text()').map{|x| x.to_s.downcase.gsub(" ","-")}
    return townhall_urls
  end

  def get_townhall_email(townhall_urls)
    array_email = []
  #townhall_email = townhall_urls.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  townhall_urls.each do |counter|
    page3 = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/#{counter}.html"))
    array_email << page3.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text.to_s
    print "."
  end
  return array_email
end

def save_as_json(list)
  File.open("db/emails.json" , "w") do |counter|
    counter.write(list.to_json)
  end
end

def perform
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  townhall_urls = get_townhall_urls(page)
  array_email = get_townhall_email(townhall_urls)
  #puts townhall_urls
  #puts array_email
  list = Hash[townhall_urls.zip(array_email)]
  save_as_json(list)
end


end
