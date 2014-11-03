module GABB

  class Program
    include GABB::ConsoleCommands

    def initialize
      greet
    end

    private

    def greet
      clear_screen
      line_break
      beat
      puts title_screen.blue
      line_break
      beat
      new_or_load
    end

    def title_screen
      <<-'title_screen'
  _______      ___      .______   .______  
 /  _____|    /   \     |   _  \  |   _  \ 
|  |  __     /  ^  \    |  |_)  | |  |_)  |
|  | |_ |   /  /_\  \   |   _  <  |   _  < 
|  |__| |  /  _____  \  |  |_)  | |  |_)  |
 \______| /__/     \__\ |______/  |______/ 
             Bug           Buster
      title_screen
    end

   def new_or_load
      puts "What would you like to do?".blue
      puts "  0: Quit".blue
      puts "  1: Start new session".blue
      puts "  2: Load session".blue
      choice = gets.strip
      case choice
        when "0" then puts "Exiting GABB!".blue; return false 
        when "1" then create_new_session
        when "2" then load_session
      else
        puts "Not a valid choice.".yellow
        new_or_load
      end
    end

    def get_session_name
      print "Enter session name: ".blue
      name = gets.chomp
    end

    def create_new_session
      session_name = get_session_name
      if GABB::Session::Manager.session_exists?(session_name)
        puts "A session with that name already exists.".yellow
        create_new_session
      else
        GABB::Session::Manager.create_session(session_name)
        enter_session(session_name)
      end
    end

    def load_session
      puts "Available sessions: "
      puts GABB::Session::Manager.session_names.map {|name| "== " + name}
      beat
      session_name = get_session_name
      if GABB::Session::Manager.session_exists?(session_name)
        enter_session(session_name)
      else
        puts "No session with that name."
        load_session
      end
    end

    def enter_session(session_name)
      GABB::Session::Base.new(session_name)
    end
  end
end