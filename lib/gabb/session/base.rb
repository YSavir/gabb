module GABB

  module Session

    class Base
      attr_reader :name

      def initialize(name)
        @name = name
        @exercises_manager = GABB::ExercisesManager.new
        menu
      end

      private

      def menu
        exercise = @exercises_manager.choose_exercise
        if exercise
          exercise.new(self)
          menu
        end
      end
    end
  end
end