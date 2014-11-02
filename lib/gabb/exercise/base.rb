module GABB

  module Exercise

    class Base
      include GABB::ConsoleCommands
      @@before_action_methods = []
      @@after_action_methods = []

      def initialize(session)
        @session = session
        @log = GABB::Logger.new(session)
        action
        @log.close
      end

      def self.before_action(*methods)
        @@before_action_methods = methods
      end

      def self.after_action(*methods)
        @@after_action_methods = methods
      end

      def self.title
        self.name.underscore.split('_').map(&:capitalize).join(' ')
      end

      def file_name
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
        execute_before_action_methods
        GABB::Exercise::Utils.prepare_exercise_for_session(self, @session)
        exposition
        begin
          rising_action
          GABB::Exercise::Utils.require_exercise_for_session(self, @session)
        rescue Exception => error
          @error = error
          find_details
          puts "", (error.to_s + "\n").yellow
          climax
          wait
          retry
        else
          resolution
        end
        execute_after_action_methods
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end

      def error_type
        Exception
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

      def log_solution
        @log.log_exercise_name(self)
        @log.get_and_log_solution(self)
      end
    end
  end
end