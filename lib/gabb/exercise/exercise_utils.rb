module GABB

  module Exercise

    module Utils

      def self.prepare_exercise_for_session(exercise, session)
        session_path = DirectoryMapper.session_path_for(session)
        exercise_path = DirectoryMapper.exercise_path_for(exercise)
        FileUtils.cp(exercise_path + "/template.rb", session_path + "/#{exercise.directory_name}.rb")
      end

      def self.load_exercise_for_session(exercise, session)
        session_path = DirectoryMapper.session_path_for(session)
        load("#{session_path}/#{exercise.directory_name}.rb")
      end

    end
  end
end