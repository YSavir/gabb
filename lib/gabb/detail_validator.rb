module GABB

  class DetailValidator
    attr_writer :guess_file_prompt, :guess_line_prompt, :incorrect_file, :incorrect_line

    def initialize(exercise)
      @exercise = exercise
      @details_are_validated = false
      @guess_file_prompt =  "In what file is the error?".blue
      @guess_line_prompt = "On what line is the error?".blue
      @incorrect_file = "That's not the right file.".yellow 
      @incorrect_line = "That's not the right line.".yellow
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
      puts @guess_file_prompt
      unless gets.chomp == @error_file
        puts @incorrect_file
        guess_file
      end
    end

    def guess_line
      puts @guess_line_prompt
      unless gets.chomp == @error_line
        puts @incorrect_line
        guess_line
      end
    end
  end
end