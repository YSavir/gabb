class PutsHi < GABB::Exercise

  def name
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
  end

  def climax
    find_details
    validate_details
    puts "Great. Go to that file and fix the issue.".blue
  end

  def falling_action
    puts "Problem fixed!".blue
  end

  def resolution
  end

end