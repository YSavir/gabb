module GABB

  module Session

    class Base
      attr_reader :name

      def initialize(name)
        @name = name
        @exercises_manager = GABB::Exercise::Manager.new
        get_and_run_exercise
      end

      private

      def get_and_run_exercise
        exercise = @exercises_manager.choose_exercise
        if exercise
          exercise.new(self)
          get_and_run_exercise
        end
      end
    end
  end
end