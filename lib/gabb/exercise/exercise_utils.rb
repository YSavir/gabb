module GABB

  module Exercise

    module Utils

      def self.prepare_exercise(exercise)
        script_file_path = DirectoryMapper.script_path_for exercise
        template_path = DirectoryMapper.template_path_for exercise
        FileUtils.cp(template_path, script_file_path)
      end

      def self.load_exercise(exercise)
        load DirectoryMapper.script_path_for exercise
      end

    end
  end
end