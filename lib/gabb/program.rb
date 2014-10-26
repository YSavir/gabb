module GABB

  class Program
    include GABB::ConsoleCommands

    def initialize
      @session_names = GABB::Session::Manager.session_names
      greet
    end

    private

    def greet
      system('clear')
      line_break
      beat
      puts "Greetings, WDI Student. Welcome to General Assembly Bug Buster!".blue
      beat
      new_or_load
      line_break
    end

    def list_sessions
      puts "Available sessions: "
      puts @session_names
    end

   def new_or_load
      puts "Would you like to start a new session or load an old session?".blue
      puts "  1: New".blue
      puts "  2: Load".blue
      choice = gets.strip
      case choice
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
      name = get_session_name
      if GABB::Session::Manager.session_exists?(name)
        puts "A session with that name already exists.".yellow
        get_new_session_name
      else
        GABB::Session::Manager.create_session(name)
        load_session(name)
      end
    end

    def load_session(name=nil)
      name ||= get_session_name
      GABB::Session::Base.new(name)
    end
  end
end