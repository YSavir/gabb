module GABB

  module Exercise

    class Base
      attr_reader :detail_validator_configuration
      include GABB::ConsoleCommands
      @@before_action_methods = []
      @@after_action_methods = []

      def self.before_action(*methods)
        @@before_action_methods += methods
      end

      def self.after_action(*methods)
        @@after_action_methods += methods
      end

      def self.configure_detail_validator(&block)
        @detail_validator_configuration = block
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

      def detail_validation_configuration
        @@detail_validator_configuration ||= Proc.new {}
      end

      def before_actions
        @@before_action_methods
      end
      
      def after_actions
        @@after_action_methods
      end

      def exposition; end
      def rising_action; end
      def climax; end
      def resolution; end

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
