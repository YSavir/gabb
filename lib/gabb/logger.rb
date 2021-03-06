module GABB
  class Logger
    include ConsoleCommands

    def initialize
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

    def get_and_log_solution
      print "Briefly describe how you solved the problem: ".blue
      solution = gets.strip
      write_to_log do |log|
        log.puts "Solution: #{solution}"
      end
      beat
      puts "Your notes have been to saved to the log. It may be found at:".blue
      beat
      puts log_file
      beat
    end

    def get_and_log_problem
      print "Describe the problem: ".blue
      problem = gets.strip
      write_to_log do |log|
        log.puts ""
        log.puts "Problem: #{problem}"
        log.puts ""
      end
      beat
    end

    def log_file
      DirectoryMapper.log_path
    end

    def close
      log_line_break
    end

    def write_to_log(&block)
      log = File.open(log_file, 'a')
      yield(log)
      log.close
    end
  end
end