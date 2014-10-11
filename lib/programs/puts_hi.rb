class PutsHi < GABB::Program

  def self.name
    "Puts Hi"
  end

  def error_type
    SyntaxError
  end

  def exposition
    puts "We're going to start by getting a method that prints 'hi' to the screen.".blue
    puts "The code for this method is found in another file. We'll have to require it before we can use the code.".blue
  end

  def rising_action
    require_relative (ROOT_DIR + 'exercises/puts_hi')
  end

  def climax(error)
    puts (error.to_s + "\n").colorize(:yellow)
    find_details
    validate_details
    puts "Great. Go to that file and fix the issue.".blue
  end

  def resolution
    File.open(log_file, 'a') do |f|
      f.puts "Exercise: missing end"
      f.puts "Error: " + error.to_s
    end
    puts "Problem fixed!".blue
    puts "Can you give me a brief explanation of what you did?".blue
    File.open(log_file, 'a') do |f|
      f.puts "Solution: "
      f.puts gets.chomp
    end
    FileUtils.cp('./exercises/puts_hi.rb', ('./output/' + current_session_name))
    FileUtils.cp('./templates/puts_hi.rb', './exercises')
  end

end