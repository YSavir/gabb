class Gabb

  def initialize(error)
    @error = error
    find_details
  end

  def log_error
    File.open('log.txt', 'a') do |f|
      f.puts "Error time: " + Time.now.to_s + "\n"
      f.puts "Error: " + @error.to_s + "\n"
    end
  end

  def find_details
    @error_line = @error.to_s.match(/(\w+):(\d+)/)[2]
    @error_file = @error.to_s.match(/(\w+.\w+):/)[1]
  end

  def validate_details
    puts "Hmm.".blue
    puts "Something went wrong. Let's figure out what.".blue
    guess_file
    guess_line
  end

  def guess_file
    puts "In what file is the error?".blue
    unless gets.chomp == @error_file
      puts("That's not the right file.".yellow)
      guess_file
    end
  end

  def guess_line
    puts "On what line is the error?".blue
    unless gets.chomp == @error_line
      puts("That's not the right line.".yellow)
      guess_line
    end
  end

end