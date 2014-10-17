module GABB

  class ExerciseUtils

    def prepare_exercise(exercise_name, directory_path)
      FileUtils.cp("./lib/templates/#{exercise_name}.rb", directory_path)
    end

    def require_exercise(exercise_name, directory_path)
      require_relative("#{directory_path}/#{exercise_name}.rb")
    end

  end

end