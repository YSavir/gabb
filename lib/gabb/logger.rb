module GABB
  class Logger

    def initialize(session)
      @session = session
    end

    def log_exercise_name(exercise)
      write_to_log("Exercise: #{exercise.class.title}")
    end

    def log_error_message(error_message)
      write_to_log("Error: #{error_message}")
    end

    def log_time
      write_to_log(Time.now)
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution } 
    end

    def log_file
      DirectoryMapper.session_path_for(@session) + '/log.txt'
    end

    def write_to_log(*items_to_log)
      log = File.open(log_file, 'a')
      items_to_log.each do |item|
        log.puts item
      end
      log.close
    end

  end
end