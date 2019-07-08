class TriangleTypes
  
  def triangle

    triangle_array = [] #set an empty array/(list) to collect user input

    side_array = ["A", "B", "C"] #set array for the triangle sides

    #Loop through the triange sides
    side_array.each do |value|
      
      #Insert exception handler to ensure correct format for user input
      begin
        puts "Enter a Value for Side #{value}" #print to console
        side = Float(gets.chomp) #assign user input and remove newline
      rescue
        puts "Wrong Input. Please enter an integer" #Throw error if user input is invalid
        retry 
      end #end begin

      puts "Side #{value} is #{side}" #print to console
      triangle_array << side # append value of user input to declared array

    end #end side_array
    puts"****************" #print to console

    combined_data = side_array.zip(triangle_array).to_h #ruby method to combine array into a hash(dictionary) of arrays
    combined_data.each { |side, value| print "Side #{side} = #{value.to_s}\n\n"} #print to console
    puts #insert two newlines for readability

    checking_value = triangle_array.uniq.count #a ruby array method that checks for unique values and then returns the count/number of occurences

    #Switch statement to check the result of declared varaible and return a string to console
    case checking_value
    when 1
      puts "Your Triangle is Equilateral"
    when 2
      puts "Your Triangle is Isosceles"
    when 3
      puts "Your Triangle is Scalene or Obtuse"
    else
      puts "Hmmmmmm....Kindly check your input again"
    end #end case

  
  end #end triangle method
end #end TriangleTypes class


TriangleTypes.new.triangle #call new instance of the class
