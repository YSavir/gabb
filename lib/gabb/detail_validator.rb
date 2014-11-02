module GABB

  class DetailValidator

    def initialize(exercise)
      @exercise = exercise
      @details_are_validated = false
    end

    def find_details(error)
      @error_line = error.to_s.match(/(\w+):(\d+)/)[2]
      @error_file = error.to_s.match(/(\w+.\w+):/)[1]
    end

    def validate_details(options={})
      unless @details_are_validated
        guess_file
        guess_line
        @details_are_validated = true unless options[:repeat]
      end
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