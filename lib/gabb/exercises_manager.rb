module GABB
  attr_reader :exercises

  class ExercisesManager

    def initialize
      prepare_exercises
    end

    def choose_exercise
      choice = nil
      while choice != '0'
        puts "Which exercise would you like to complete? (Enter the corresponding number)".blue
        puts "  0: Quit".blue
        @exercises.each { |idx, exercise| puts "  #{idx}: #{exercise.title}".blue  if (idx.to_i > 0)}
        choice = gets.chomp
        case choice
          when "0" then puts "Exiting General Assembly Bug Buster!".blue
          when *@exercises.keys then return @exercises[choice]
        else
          puts "Invalid choice. Please select a different options.".yellow
        end
      end
    end

    private

    def exercises
      GABB::Exercise.descendants.map(&:to_s)
    end

    def prepare_exercises
      exercises_with_indexes = exercises.each_with_index.map do |exercise, idx|
        [(idx + 1).to_s, exercise.constantize]
      end
      @exercises = Hash[exercises_with_indexes]
    end

  end

end