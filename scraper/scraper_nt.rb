require 'httparty'
require 'nokogiri'
require 'byebug'
require 'prawn'


# ........................New Testament here ..........................................#


def scraper_nt
  url = 'https://www.biblegateway.com/versions/The-Living-Bible-TLB/#booklist'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  book_lists_ot = parsed_page.css('tr.nt-book') #39 Old testament Books

  new_testament_list = []
  new_testament_chapters = []
  book_lists_ot.each do |book_list| #Iterate through the book list
    
    ab = (book_list.css('td.book-name').text)
    nt_book = {
      name: ab.gsub(/\d+$/, ""), #Strips out the one or more digits at end of line
      total_chapters: ab.gsub(/(^\d)|\D/, "").to_i #strips out the beginning numbers and letters, and converts to integer
    }
    book_chapter = book_list.css('td.chapters')

    book_chapter.each do |chapter|
      chapter_tag = chapter.css('a')

      chapter_tag.each do |tag|

        nt_chapter_list = {
          name: ab.gsub(/\d+$/, ""), #Strips out the one or more digits at end of line
          title: tag.attributes["title"].value,
          link: "https://www.biblegateway.com" + tag.attributes["href"].value
        }
        new_testament_chapters << nt_chapter_list
      end
    end 
    new_testament_list << nt_book

    
  end

  #/............................................................................../

  the_living_bible = []
  
  # new_testament_list.each do |book| #iterate through the list of books
  #   # book[:name].each do |name| #find each book
    
    # chapter_count = 0
    # while chapter_count <= 1
      new_testament_chapters.each do |chapter|

          chapter_url = chapter[:link]
          chapter_unparsed_page = HTTParty.get(chapter_url)
          chapter_parsed_page = Nokogiri::HTML(chapter_unparsed_page)
          chapter_page_content = chapter_parsed_page.css('//span.text').text.gsub(/[0-9]+(-[0-9]+)|[0-9]+/, "\n\n \\0").gsub(/[*]/, "") #grab chapter text, add new line on each verse and remove special character
        
          chapter_page_header = chapter_parsed_page.css('//span.passage-display-bcv').text.gsub(/[0-9]+(-[0-9]+)|[0-9]+/, "\\0 ") #Grabs the Chapter Header
        
          chapter_content = {
            header: chapter_page_header,
            content: chapter_page_content
          }
          
          the_living_bible << chapter_content
          puts "#{chapter[:title]} from link #{chapter[:link]} added to The Living Bible (New Testament)"
          puts "**************************************"
          
      end  
      #   chapter_count += 1
        
      # end   
      
      
  # end  
    the_living_bible_pdf = Prawn::Document.new

    the_living_bible.each do |the_bible|
     
      the_living_bible_pdf.font_families.update("Roboto"=>{:normal =>"fonts/Roboto/Roboto-Regular.ttf"})
      the_living_bible_pdf.font "Roboto"

      the_living_bible_pdf.font_size(25) {the_living_bible_pdf.text "#{the_bible[:header]}: "}
      the_living_bible_pdf.move_down 20
      the_living_bible_pdf.text "#{the_bible[:content]}"
      the_living_bible_pdf.start_new_page
      
    end 

    the_living_bible_pdf.render_file "the_living_bible(NT).pdf"
    puts "**********The Living Bible (New Testament) crawled and created successfully**************"
    
  
end 

scraper_nt