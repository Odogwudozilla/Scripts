require 'httparty'
require 'nokogiri'
require 'byebug'
require 'prawn'


# ........................New Testament here ..........................................#


def try_scrap
  url = 'https://www.lessismoreeshop.com/product-page/chaussettes-bleed'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  main_cont = parsed_page.css('div.content-wrapper') 

  byebug
end 

try_scrap