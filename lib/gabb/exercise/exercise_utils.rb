module GABB

  module Exercise

    module Utils

      def self.prepare_exercise_for_session(exercise, session)
        path = DirectoryMapper.new(session: session).session_path
        FileUtils.cp("./lib/templates/#{exercise.file_name}.rb", path)
      end

      def self.require_exercise_for_session(exercise, session)
        path = DirectoryMapper.new(session: session).session_path
        require_relative("#{path}/#{exercise.file_name}.rb")
      end
    end
  end
end