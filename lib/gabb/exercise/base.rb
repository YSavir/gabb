module GABB

  module Exercise

    class Base
      include GABB::ConsoleCommands
      @@before_action_methods = []
      @@after_action_methods = []
      @@detail_validator = GABB::DetailValidator.new(self)

      def initialize(session)
        @session = session
        @log = GABB::Logger.new(session)
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
        GABB::Exercise::Utils.prepare_exercise_for_session(self, @session)
        beat
        exposition
        beat
        begin
          rising_action
          beat
          GABB::Exercise::Utils.load_exercise_for_session(self, @session)
        rescue Exception => error
          @@detail_validator.find_details(error)
          beat
          puts (error.to_s + "\n").yellow
          beat
          climax
          beat
          wait
          retry
        else
          resolution
          beat
        end
        execute_after_action_methods
      end

      def validate_details(options={})
        @@detail_validator.validate_details(options)
      end

      def log_solution
        @log.log_exercise_name(self)
        @log.get_and_log_solution
      end
    end
  end
end