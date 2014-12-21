module GABB

  module DirectoryMapper

    def self.scripts_path
      File.expand_path './scripts'
    end

    def self.script_path_for(exercise)
      File.expand_path "./#{exercise.directory_name}.rb", scripts_path
    end

    def self.exercises_path_for(exercise)
      File.expand_path exercise.directory_name, "./lib/exercises/"
    end

    def self.template_path_for(exercise)
      File.expand_path "./template.rb", exercises_path_for(exercise)
    end

    def self.log_path
      File.expand_path "./log.txt"
    end
    
  end
end