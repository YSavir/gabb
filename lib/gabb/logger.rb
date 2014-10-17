module GABB

  class Logger

    def initialize(session_name)
      @session_name = session_name
    end

    def log_exercise_name(exercise_name)
      File.open(log_file, 'a') { |log| log.puts "Exercise: #{exercise_name}" }
    end

    def log_error_message(error_message)
      File.open(log_file, 'a') { |log| log.puts "Error: #{error_message}" }
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution } 
    end

    private

    def log_file
      directory_path + '/log.txt'
    end

    def directory_path
      Dir.pwd + '/sessions/' + @session_name
    end

  end

end