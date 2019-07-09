class TriangleTypes
  
  puts "This program collects three inputs (representing 'sides') from the user and then determines the type of triangle, given those sides. Remember, for a triangle to be valid, the sum of any 2 sides will always be greater than the third side. Let's begin..."
  sleep(2)


  def prompts
    
    your_try = 0
    while your_try <= 3
      puts "Do you want to continue?(y/n)"
      confirm = gets.chomp
      if your_try == 3 || confirm.downcase == "n" 
        print "Eiyaa..Exiting...bye..."
        sleep(3)
        puts "done"
        exit
      elsif confirm.downcase == "y"
        puts "Thank you, will now execute your instructions"
        break
      else
        puts "WRONG user input!!! Please try again"
      end  
      your_try += 1 #increment your_try
      puts "This is your number #{your_try} try. You have #{3 - your_try} trys left"
    end #end while loop
    
  end # end prompts

  
  def userinput

    @@triangle_array = [] #set an empty array/(list) to collect user input

    @@side_array = ["A", "B", "C"] #set array for the triangle sides

    #Loop through the triange sides
    @@side_array.each do |value|
      
      #Insert exception handler to ensure correct format for user input
      begin
        puts "Enter a Value for Side #{value}" #print to console
        side = Float(gets.chomp) #assign user input and remove newline
      rescue
        puts "Wrong Input. Please enter an integer or float" #Throw error if user input is invalid
        retry #repeat the current loop
      end #end begin

      puts "Your input is #{side}" #print to console
      @@triangle_array << side # append value of user input to declared array

    end #end side_array
    puts"****************" #print to console
    
  end #end userinput
  
  
  def methodlogic
    #Sorts the array in ascending order and then compares the two smallest with the largest side
    sorted_array = @@triangle_array.sort
    unless sorted_array[0] + sorted_array[1] > sorted_array.last
      puts "Unfortunately, your inputed figures will not form a valid triangle as #{sorted_array[0]} plus #{sorted_array[1]} is less than  #{sorted_array.last}. You will have to try again"
      prompt #reruns the method
      userinput # reruns the method
    end #end unless

    @@combined_data = @@side_array.zip(@@triangle_array).to_h #ruby method to combine array into a hash(dictionary) of arrays
    @@combined_data.each { |side, value| print "Side #{side} = #{value.to_s}\n\n"} #print to console
    puts #insert two newlines for readability
  
    @@checking_value = @@triangle_array.uniq.count #a ruby array method that checks for unique values and then returns the count/number of occurences
    
  end #end methodlogic


  def checkvalue
    prompts
    userinput
    methodlogic

    #Switch statement to check the result of declared variable and return a string to console
    case @@checking_value
    when 1
      puts "Your Triangle is Equilateral"
    when 2
      puts "Your Triangle is Isosceles"
    when 3
      puts "Your Triangle is Scalene or Obtuse"
    else
      puts "Hmmmmmm....this is strange indeed"
      exit
    end #end case
  
  end #end checkvalue


end #end TriangleTypes class


TriangleTypes.new.checkvalue #call new instance of the class
