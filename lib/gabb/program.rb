module GABB

  class Program

    ROOT_DIR = '../../'

    def initialize
      action
      # find_details
    end

    def self.title
      name || self.class
    end

    def name
      nil
    end

    def action
      exposition
      begin
        rising_action
      rescue error_type => error
        @error = error
        climax(error)
        retry
      else
        resolution
      end
    end

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def error_type
      StandardError
    end

    def wait
      "Press Enter to proceed.".blue
      gets.chomp
    end

    def find_details
      @error_line = @error.to_s.match(/(\w+):(\d+)/)[2]
      @error_file = @error.to_s.match(/(\w+.\w+):/)[1]
    end

    def validate_details
      puts "Hmm.".blue
      puts "Something went wrong. Let's figure out what.".blue
      guess_file
      guess_line
    end

    def guess_file
      puts "In what file is the error?".blue
      unless gets.chomp == @error_file
        puts("That's not the right file.".yellow)
        guess_file
      end
    end

    def guess_line
      puts "On what line is the error?".blue
      unless gets.chomp == @error_line
        puts("That's not the right line.".yellow)
        guess_line
      end
    end

  end

end