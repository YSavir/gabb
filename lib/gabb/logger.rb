module GABB
  class Logger

    def initialize(session)
      @session = session
    end

    def log_exercise_name(exercise)
      File.open(log_file, 'a') { |log| log.puts "Exercise: #{exercise.class.title}" }
    end

    def log_error_message(error_message)
      File.open(log_file, 'a') { |log| log.puts "Error: #{error_message}" }
    end

    def log_time
      File.open(log_file, 'a') { |log| log.puts Time.now }
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution } 
    end

    def log_file
      DirectoryMapper.session_path_for(@session) + '/log.txt'
    end
  end
end