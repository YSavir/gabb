module GABB

  class Manager

    ROOT_DIR = '../..'

    def initialize
      # setup_session
      prepare_exercises
      puts "Greetings, WDI Student. Welcome to General Assembly Bug Buster!".blue
      choice = nil
      while choice != '0'
        puts "Which exercise would you like to complete? (Enter the corresponding number)".blue
        puts "0: Quit".blue
        @exercises.each { |idx, exercise| puts "#{idx}: #{exercise.name}".blue }
        choice = gets.chomp
        @exercises[choice].instance_of?(Proc) ? @exercises[choice].call : @exercises[choice].new
      end
    end

    def start_session
      puts "This exercise will explore a few ruby errors and how to solve them.".blue
      print "Are you ready?".blue
      wait
      FileUtils.cp(ROOT_DIR + '/templates/puts_hi.rb', ROOT_DIR.pwd + './exercises')
    end

    private

    def wait
      "Press Enter to proceed.".blue
      gets.chomp
    end

    def exercises
      GABB::Program.descendants.map(&:to_s)
    end

    def prepare_exercises
      @exercises = Hash.new(Proc.new {puts "Not a valid choice.".white})
      exercises.each_with_index { |exercise, idx| @exercises[(idx + 1).to_s] = exercise.constantize}
    end

    def setup_session
      @current_session_name = Time.now.to_s
      FileUtils.mkdir('./output/' + current_session_name)
      log_file = './output/' + current_session_name + '/log.txt'
      FileUtils.touch(log_file)
    end

  end

end