# This script is meant to iterate through all the files in the folder it was run
# Create named folders according to the file types
# Move each file in the corresponding folder 
# Create a text file listing the files moved and to which folder, including the date

require 'fileutils'

class FileRename

  def initial_checks

    # Sets the directory
    @@current_dir = Dir.pwd
    # Sets the name to the current directory name
    @@dir_basename = File.basename(Dir.getwd)
  
    # Initialises the date and time
    time = Time.now
    @@timestamp = time.strftime('%Y-%m-%d >> %X')
  
    puts "The Current Directory is \" #{@@current_dir}\" "

    total_files = Dir.glob("*")
    puts 
    puts "There are total of #{total_files.count} files in this directory"
   
  end

  def prompts
    puts "Do you want to continue moving files? (y/n)"
    answer = gets.chomp
    unless answer == "y"
      puts "Exiting..."
      sleep(3)
      exit  
    end 
  end

  def ignore_exception
   begin
     yield  
   rescue Exception
   end
  end

  ######################################################################
  # Method for moving Picture files
  def movePics
    ignore_exception { puts "Ignoring Exception"; raise Exception; puts "This is Ignored" }
    initial_checks
    prompts
    
    # Filters the total number of pictures
    pic_files = Dir.glob("*.{jpeg,jpg,png,tiff,gif,bmp,WebP,Exif}")
    puts "There are #{pic_files.count} Pictures in this directory"

    prompts

    # Creates the Pictures directory
    pic_dir = "#{@@current_dir}/#{@@dir_basename}" + "_" + "Pictures"
    FileUtils.mkdir_p pic_dir
    # Moves the files 
    pic_files.each do |pic|
      FileUtils.mv pic, pic_dir
    end

    pic_txt = File.new("#{pic_dir}/Moved_Pictures.txt", "a+"); pic_txt.write("\n \nFiles automatically moved to this folder today #{@@timestamp}: \n#{pic_files.entries.join("\n")}"); pic_txt.close
    
    puts "A total of #{pic_files.count} Picture files were successfully moved to \" #{pic_dir}\" "
    puts
  end 

  ######################################################################
  # Method for moving PDF files
  def movepdfs
    ignore_exception { puts "Ignoring Exception"; raise Exception; puts "This is Ignored" }
    initial_checks
    prompts
    
    # Filters the total number of PDFs
    pdf_files = Dir.glob("*.{pdf,xps}")
    puts "There are #{pdf_files.count} PDFs in this directory"

    prompts

    # Creates the PDFs directory
    pdf_dir = "#{@@current_dir}/#{@@dir_basename}" + "_" + "PDFs"
    FileUtils.mkdir_p pdf_dir
    # Moves the files 
    pdf_files.each do |pdf|
      FileUtils.mv pdf, pdf_dir
    end

    pdf_txt = File.new("#{pdf_dir}/Moved_PDFs.txt", "a+"); pdf_txt.write("\n \nFiles automatically moved to this folder today #{@@timestamp}: \n#{pdf_files.entries.join("\n")}"); pdf_txt.close
    
    puts "A total of #{pdf_files.count} PDF files were successfully moved to \" #{pdf_dir}\" "
    puts
  end 

  
  ######################################################################
  # Method for moving doc files
  def moveDocs
    ignore_exception { puts "Ignoring Exception"; raise Exception; puts "This is Ignored" }
    initial_checks
    prompts
    
    # Filters the total number of Docs
    doc_files = Dir.glob("*.{doc,docx,xls,xlsx,csv}")
    puts "There are #{doc_files.count} Docs in this directory"

    prompts

    # Creates the Docs directory
    doc_dir = "#{@@current_dir}/#{@@dir_basename}" + "_" + "Docs"
    FileUtils.mkdir_p doc_dir
    # Moves the files 
    doc_files.each do |doc|
      FileUtils.mv doc, doc_dir
    end

    doc_txt = File.new("#{doc_dir}/Moved_Docs.txt", "a+"); doc_txt.write("\n \nFiles automatically moved to this folder today #{@@timestamp}: \n#{doc_files.entries.join("\n")}"); doc_txt.close
    
    puts "A total of #{doc_files.count} doc and excel files were successfully moved to \" #{doc_dir}\" "
    puts
  end 


  ######################################################################
  # Method for moving audio files
  def moveAudios
    ignore_exception { puts "Ignoring Exception"; raise Exception; puts "This is Ignored" }
    initial_checks
    prompts
    
    # Filters the total number of Audios
    audio_files = Dir.glob("*.{mp3,wave,m3u,aiff,aac,ogg,wma,flac,pcm}")
    puts "There are #{audio_files.count} Audios in this directory"

    prompts

    # Creates the Audios directory
    audio_dir = "#{@@current_dir}/#{@@dir_basename}" + "_" + "Audios"
    FileUtils.mkdir_p audio_dir
    # Moves the files 
    audio_files.each do |audio|
      FileUtils.mv audio, audio_dir
    end

    audio_txt = File.new("#{audio_dir}/Moved_Audios.txt", "a+"); audio_txt.write("\n \nFiles automatically moved to this folder today #{@@timestamp}: \n#{audio_files.entries.join("\n")}"); audio_txt.close
    
    puts "A total of #{audio_files.count} audio files were successfully moved to \" #{audio_dir}\" "
    puts
  end 

  
  ######################################################################
  # Method for moving video files
  def moveVideos
    ignore_exception { puts "Ignoring Exception"; raise Exception; puts "This is Ignored" }
    initial_checks
    prompts
    
    # Filters the total number of Videos
    video_files = Dir.glob("*.{flv,avi,mov,mp4,mpg,wmv,3gp,asf,avchd,DivX,MPEG-1,MPEG-2,MPEG-4,WebM}")
    puts "There are #{video_files.count} Videos in this directory"

    prompts

    # Creates the Videos directory
    video_dir = "#{@@current_dir}/#{@@dir_basename}" + "_" + "Videos"
    FileUtils.mkdir_p video_dir
    # Moves the files 
    video_files.each do |video|
      FileUtils.mv video, video_dir
    end

    video_txt = File.new("#{video_dir}/Moved_Videos.txt", "a+"); video_txt.write("\n \nFiles automatically moved to this folder today #{@@timestamp}: \n#{video_files.entries.join("\n")}"); video_txt.close
    
    puts "A total of #{video_files.count} video files were successfully moved to \" #{video_dir}\" "
    puts
  end 


  ######################################################################
  # Method for Drawing Pyramid
  def print_horizontal_pyramid
    13.times {|n|
      print ' ' * (13 - n)
      puts '*' * (2 * n + 1)
      sleep(0.5)
    }
    puts " ODOGWUDOZILLA na ekene gi"
  end

end

mvfiles = FileRename.new 
mvfiles.movePics
mvfiles.movepdfs
mvfiles.moveDocs
mvfiles.moveAudios
mvfiles.moveVideos
mvfiles.print_horizontal_pyramid