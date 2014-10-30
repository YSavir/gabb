class PutsHi < GABB::Exercise::Base

  def exposition
    puts "We're going to start by getting a method that prints 'hi' to the screen.".blue
    puts "The code for this method is found in another file. We'll have to require it before we can use the code.".blue
  end

  def rising_action
    puts "Requiring puts_hi.rb..."
  end

  def climax
    validate_details
    puts "Great. Go to that file and fix the issue.".blue
  end

  def resolution
    puts "Problem fixed!".blue
  end

end