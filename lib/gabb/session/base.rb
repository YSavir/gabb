module GABB

  module Session

    class Base
      attr_reader :name

      def initialize(name)
        @name = name
        @exercises_manager = GABB::ExercisesManager.new
        start_exercise
      end

      private

      def start_exercise
        exercise = @exercises_manager.choose_exercise
        exercise.new(self)
      end
    end
  end
end