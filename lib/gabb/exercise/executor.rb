module GABB

  module Exercise

    class Executor
      include GABB::ConsoleCommands

      def initialize(exercise)
        @exercise = exercise
        @detail_validator = GABB::DetailValidator.new
        @log = GABB::Logger.new
        @log.log_exercise_name(@exercise)
        @log.close
        @exercise.detail_validation_configuration.call(@detail_validator)
      end
    
      def run_exercise
        @exercise.before_actions.each { |action| @exercise.send(action) }
        GABB::Exercise::Utils.prepare_exercise(@exercise)
        beat
        @exercise.exposition
        beat
        begin
          @exercise.rising_action
          beat
          GABB::Exercise::Utils.load_exercise(@exercise)
          @exercise.run_specs
        rescue TestingError => error
          print_error(error)
          retry
        rescue Exception => error
          @detail_validator.find_details(error)
          print_error(error)
          retry
        ensure
          @exercise.resolution
          beat
        end
        @exercise.after_actions.each { |action| @exercise.send(action) }
      end

      def print_error(error)
        beat
        puts(error.to_s + "\n").red
        beat
        @exercise.climax
        beat
        wait
      end 
      
      def log_solution
        @log.get_and_log_solution
      end

      def log_problem
        @log.get_and_log_problem
      end

    end
  end
end
