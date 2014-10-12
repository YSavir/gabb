module GABB

  class Session

    def initialize
      new_or_load
    end

    private

    def directory_path
      Dir.pwd + '/sessions/' + @name
    end

    def log_file
      directory_path + '/log.txt'
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

    def log_exercise(exercise_name)
      File.open(log_file, 'a') { |log| log.puts "Exercise: #{exercise_name}" }
    end

    def log_error(error_message)
      File.open(log_file, 'a') { |log| log.puts "Error: #{error_message}" }
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution } 
    end

    def add_exercise(exercise_name)
      FileUtils.cp("./lib/exercises/#{exercise_name}", directory_path)
    end

    def require_exercise(exercise)
      require_relative(directory_path + exercise)
    end

  end

end