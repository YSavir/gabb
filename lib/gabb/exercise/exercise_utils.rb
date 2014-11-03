module GABB

  module Exercise

    module Utils

      def self.prepare_exercise_for_session(exercise, session)
        path = DirectoryMapper.session_path_for(session)
        FileUtils.cp("./lib/templates/#{exercise.file_name}.rb", path)
      end

      def self.load_exercise_for_session(exercise, session)
        path = DirectoryMapper.session_path_for(session)
        load("#{path}/#{exercise.file_name}.rb")
      end
    end
  end
end