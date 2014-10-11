module GABB

  class Manager
    include GABB::Commands

    ROOT_DIR = '../../'

    def initialize
      # setup_session
      GABB::Session.new({name: 'boo'})
      prepare_exercises
      puts "Greetings, WDI Student. Welcome to General Assembly Bug Buster!".blue
      choice = nil
      while choice != '0'
        puts "Which exercise would you like to complete? (Enter the corresponding number)".blue
        puts "  0: Quit".blue
        @exercises.each { |idx, exercise| puts "  #{idx}: #{exercise.name}".blue  if (idx.to_i > 0)}
        choice = gets.chomp
        case choice
          when "0" then puts "Exiting General Assembly Buster!".blue
          when *@exercises.keys then @exercises[choice].new
        else
          puts "Invalid choice. Please select a different options.".yellow
        end
      end
    end

    def start_session
      puts "This exercise will explore a few ruby errors and how to solve them.".blue
      print "Are you ready?".blue
      wait
      FileUtils.cp(ROOT_DIR + '/templates/puts_hi.rb', ROOT_DIR.pwd + './exercises')
    end

    private

    def exercises
      GABB::Program.descendants.map(&:to_s)
    end

    def prepare_exercises
      @exercises = Hash.new
      exercises.each_with_index { |exercise, idx| @exercises[(idx + 1).to_s] = exercise.constantize}
    end

    def setup_session
      log_file = './output/' + current_session_name + '/log.txt'
      FileUtils.touch(log_file)
    end

    def start_new_session
      create_session(get_session_name)
    end

    def get_session_name
      "Session name?"
      @session_name = gets.strip
    end

    def create_session

    end

  end

end