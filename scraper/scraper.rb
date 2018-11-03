require 'httparty'
require 'nokogiri'
require 'byebug'
require 'prawn'

def scraper
  url = 'https://www.biblegateway.com/versions/The-Living-Bible-TLB/#booklist'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  book_lists_ot = parsed_page.css('tr.ot-book') #39 Old testament Books

  old_testament_list = []
  old_testament_chapters = []
  book_lists_ot.each do |book_list| #Iterate through the book list
    
    ab = (book_list.css('td.book-name').text)
    book = {
      name: ab.gsub(/\d+$/, ""), #Strips out the one or more digits at end of line
      total_chapters: ab.gsub(/(^\d)|\D/, "").to_i #strips out the beginning numbers and letters, and converts to integer
    }
    book_chapter = book_list.css('td.chapters')

    book_chapter.each do |chapter|
      chapter_tag = chapter.css('a')

      chapter_tag.each do |tag|

        chapter_list = {
          name: ab.gsub(/\d+$/, ""), #Strips out the one or more digits at end of line
          title: tag.attributes["title"].value,
          link: "https://www.biblegateway.com" + tag.attributes["href"].value
        }
        old_testament_chapters << chapter_list
      end
    end 
    old_testament_list << book

    
  end

  #/............................................................................../

  the_living_bible = []
  
  # old_testament_list.each do |book| #iterate through the list of books
    # book[:name].each do |name| #find each book
    
    # chapter_count = 0
    # while chapter_count <= 1
    old_testament_chapters.each do |chapter|

          chapter_url = chapter[:link]
          chapter_unparsed_page = HTTParty.get(chapter_url)
          chapter_parsed_page = Nokogiri::HTML(chapter_unparsed_page)
          chapter_page_content = chapter_parsed_page.css('//span.text').text.gsub(/[0-9]+(-[0-9]+)|[0-9]+/, "\n\n \\0").gsub(/[*]/, "") #grab chapter text, add new line on each verse and remove special character
        
          chapter_page_header = chapter_parsed_page.css('//span.passage-display-bcv').text.gsub(/[0-9]{2}(-[0-9]{2})|[1-9]{2}/, "\\0 ") #Grabs the Chapter Header
        
          chapter_content = {
            header: chapter_page_header,
            content: chapter_page_content
          }
          
          the_living_bible << chapter_content
          puts "#{chapter[:title]} from link #{chapter[:link]} added to The Living Bible (Old Testament)"
          puts "**************************************"
          
        # end  
      #   chapter_count += 1
        
      # end   
      
      # end  
    end  
    the_living_bible_pdf = Prawn::Document.new
    the_living_bible_pdf.font_size(40) {the_living_bible_pdf.text "The Living Bible (Old Testament)"}
    the_living_bible.each do |the_bible|
     
      the_living_bible_pdf.font_families.update("Roboto"=>{:normal =>"fonts/Roboto/Roboto-Regular.ttf"})
      the_living_bible_pdf.font "Roboto"

      the_living_bible_pdf.font_size(25) {the_living_bible_pdf.text "#{the_bible[:header]}: "}
      the_living_bible_pdf.move_down 20
      the_living_bible_pdf.text "#{the_bible[:content]}"
      the_living_bible_pdf.start_new_page
      
    end 
    the_living_bible_pdf.move_down 100
    the_living_bible_pdf.font_size(9) {the_living_bible_pdf.text "crawled from 'https://www.biblegateway.com' by Odogwudozilla"}
    the_living_bible_pdf.render_file "the_living_bible(OT).pdf"

    puts "**********The Living Bible (Old Testament) crawled and created successfully**************"
    
    # byebug
  
end 




scraper