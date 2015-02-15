module GABB

  class Program
    include GABB::ConsoleCommands

    def initialize
      greet
    end

    private

    def greet
      clear_screen
      line_break
      beat
      puts title_screen.blue
      line_break
      beat
      get_and_run_exercise
    end

    def title_screen
      <<-'title_screen'
  _______      ___      .______   .______  
 /  _____|    /   \     |   _  \  |   _  \ 
|  |  __     /  ^  \    |  |_)  | |  |_)  |
|  | |_ |   /  /_\  \   |   _  <  |   _  < 
|  |__| |  /  _____  \  |  |_)  | |  |_)  |
 \______| /__/     \__\ |______/  |______/ 
             Bug           Buster
      title_screen
    end

    private

    def get_and_run_exercise
      @exercises_manager = GABB::Exercise::Manager.new
      exercise = @exercises_manager.choose_exercise
      if exercise
        executor = GABB::Exercise::Executor.new(exercise.new)
        executor.run_exercise
        get_and_run_exercise
      end
    end

  end
end
