module GABB
  class Logger

    def initialize(session)
      @session = session
    end

    def log_exercise_name(exercise)
      write_to_log do |log|
        log.puts "Exercise: #{exercise.class.title}"
      end
    end

    def log_error_message(error_message)
      write_to_log do |log|
        log.puts "Error: #{error_message}"
      end
    end

    def log_time
      write_to_log do |log|
        log.puts Time.now
      end
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution } 
    end

    def log_file
      DirectoryMapper.session_path_for(@session) + '/log.txt'
    end

    def write_to_log(&block)
      log = File.open(log_file, 'a')
      yield(log)
      log.close
    end

  end
end