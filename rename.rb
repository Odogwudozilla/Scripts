# This script is meant to iterate through all the files in the folder it was run
# Create named folders according to the file types
# Move each file in the corresponding folder 
# Create a text file listing the files moved and to which folder, including the date

require 'fileutils'

class FileRename

  def initial_checks

    # Sets the directory
    @@current_dir = Dir.pwd
  
    # Initialises the date and time
    time = Time.now
    @@timestamp = time.strftime('%Y-%m-%d >> %X')
  
    puts "the Current Directory is \" #{@@current_dir}\" "

    total_files = Dir.glob("*")
    puts "there are total of #{total_files.count} files in this directory"
    
    # confirm = prompt "Are you sure you want to continue? (Y/N) "
    # exit if confirm == "N" || confirm == "n"
  end

  def prompts
    puts "Do you want to continue? (y/n)"
    answer = gets.chomp
    return unless answer == "y"
  end 

  
  def movePics
    initial_checks
    prompts
    
    pic_files = Dir.glob("*.{jpeg,jpg,png,tiff,gif,bmp,WebP,Exif}")
    pic_dir = "#{@@current_dir}/Pictures"
    FileUtils.mkdir_p pic_dir
    pic_files.each do |pic|
      FileUtils.mv pic, pic_dir
    end

    pic_txt = File.new("#{pic_dir}/Moved_Pictures.txt", "a+"); pic_txt.write("\n \nFiles moved to this folder today #{@@timestamp}: \n#{pic_files.entries.join("\n")}"); pic_txt.close
    
    puts "A total of #{pic_files.count} Picture files were successfully moved to \" #{pic_dir}\" "
  end 

end

mvpic = FileRename.new 
mvpic.movePics