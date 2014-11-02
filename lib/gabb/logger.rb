module GABB
  class Logger

    def initialize(session)
      @session = session
      log_line_break
      log_time
    end

    def log_exercise_name(exercise)
      write_to_log do |log|
        log.puts "Exercise: #{exercise.class.title}"
        log.puts ""
      end
    end

    def log_error_message(error_message)
      write_to_log do |log|
        log.puts ""
        log.puts "Error: #{error_message}"
        log.puts ""
      end
    end

    def log_time
      write_to_log do |log|
        log.puts Time.now
        log.puts ""
      end
    end

    def log_line_break
      write_to_log do |log|
        log.puts "==============================="
      end
    end

    def get_and_log_solution(solution)
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      File.open(log_file, 'a') { |log| log.puts "Solution: ", solution }
      puts "Your notes have been to saved to the session's log. It may be found at:".blue
      puts log_file 
    end

    def log_file
      DirectoryMapper.session_path_for(@session) + '/log.txt'
    end

    def close
      log_line_break
    end

    private

    def write_to_log(&block)
      log = File.open(log_file, 'a')
      yield(log)
      log.close
    end

  end
end