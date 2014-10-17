module GABB

  class Session
    attr_reader :name

    def initialize
      @exercises_manager = GABB::ExercisesManager.new
      puts "Greetings, WDI Student. Welcome to General Assembly Bug Buster!".blue
      new_or_load
      start_exercise
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

    def directory_path
      Dir.pwd + '/sessions/' + @name
    end


    def start_exercise
      exercise = @exercises_manager.choose_exercise
      exercise.new(self)
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