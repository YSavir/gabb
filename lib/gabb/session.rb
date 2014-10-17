module GABB

  class Session
    attr_reader :name

    def initialize
      new_or_load
      prepare_exercises
      menu
    end

    def require_exercise(exercise_name)
      require_relative("#{directory_path}/#{exercise_name}.rb")
    end

    private

    def prepare_exercise(exercise_name)
      FileUtils.cp("./lib/templates/#{exercise_name}.rb", directory_path)
    end

    def greet
      puts "Greetings, WDI Student. Welcome to General Assembly Bug Buster!".blue
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
        puts "Not a valid choice."
        new_or_load
      end
    end

    def prepare_exercises
      @exercises = Hash.new
      exercises.each_with_index { |exercise, idx| @exercises[(idx + 1).to_s] = exercise.constantize}
    end

    def menu
      choice = nil
      while choice != '0'
        puts "Which exercise would you like to complete? (Enter the corresponding number)".blue
        puts "  0: Quit".blue
        @exercises.each { |idx, exercise| puts "  #{idx}: #{exercise.name}".blue  if (idx.to_i > 0)}
        choice = gets.chomp
        case choice
          when "0" then puts "Exiting General Assembly Bug Buster!".blue
          when *@exercises.keys then @exercises[choice].new(self)
        else
          puts "Invalid choice. Please select a different options.".yellow
        end
      end
    end

    def exercises
      GABB::Exercise.descendants.map(&:to_s)
    end

    def create_new_session
      print "Enter a name for the session: ".blue
      name = gets.chomp
      if Dir.exists?('./sessions/' + name)
        puts "A session with that name already exists.".yellow
        create_new_session
      else
        @name = name
        FileUtils.mkdir(directory_path)
        FileUtils.touch(directory_path + '/log.txt')
      end
    end

  end

end