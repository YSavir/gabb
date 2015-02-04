module GABB

  module Exercise

    class Base
      include GABB::ConsoleCommands
      @@before_action_methods = []
      @@after_action_methods = []
      @@detail_validator = GABB::DetailValidator.new(self)

      def initialize
        @log = GABB::Logger.new
        @log.log_exercise_name(self)
        action
        @log.close
      end

      def self.before_action(*methods)
        @@before_action_methods += methods
      end

      def self.after_action(*methods)
        @@after_action_methods += methods
      end

      def self.configure_detail_validator(&block)
        yield(@@detail_validator)
      end

      def self.title
        self.name.underscore.split('_').map(&:capitalize).join(' ')
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end

      def directory_name
        self.class.name.underscore
      end

      private

      def exposition
      end

      def rising_action
      end

      def climax
      end

      def resolution
      end

      def execute_before_action_methods
        @@before_action_methods.each { |method| self.send(method) }
      end

      def execute_after_action_methods
        @@after_action_methods.each { |method| self.send(method) }
      end

      def action
        clear_screen
        execute_before_action_methods
        GABB::Exercise::Utils.prepare_exercise(self)
        beat
        exposition
        beat
        begin
          rising_action
          beat
          GABB::Exercise::Utils.load_exercise(self)
          run_specs
        rescue TestingError => error
          beat
          puts (error.to_s + "\n").red
          beat
          climax
          beat
          wait
        rescue Exception => error
          @@detail_validator.find_details(error)
          beat
          puts (error.to_s + "\n").red
          beat
          climax
          beat
          wait
          retry
        ensure
          resolution
          beat
        end
        execute_after_action_methods
      end

      def validate_details(options={})
        @@detail_validator.validate_details(options)
      end

      def log_solution
        @log.get_and_log_solution
      end

      def log_problem
        @log.get_and_log_problem
      end

      def run_specs
        temp_file = Tempfile.new('testing-output.txt')
        spec_file = DirectoryMapper.spec_path_for(self)
        spec_results = RSpec::Core::Runner.run([spec_file], temp_file, temp_file)
        temp_file.close
        temp_file.unlink
        # if spec_results != 0 then raise TestingError end
        raise TestingError if spec_results != 0
      end

    end
  end
end