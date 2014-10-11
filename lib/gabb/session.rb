module GABB

  class Session

    def initialize
      add_session_directory if options[:new]
    end

    private

    def directory_path
      './sessions/' + @name
    end

    def new_or_load
      puts "Would you like to start a new session or load an old session?"
      puts "  0: New"
      puts "  1: Load"
      choice = gets.strip.downcase
      case choice
        when "new" then start_new_session
        when "load" then load_session
      else
        puts "Not a valid choice."
        new_or_load
      end
    end

    def start_new_session
      p "Enter a name for the session: "
      name = gets.chomp
      if Dir.exists?(name)
        puts "A session with that name already exists."
        start_new_session
      else
        @name = name
        FileUtils.mkdir(directory_path)
        FileUtils.touch(directory_path + '/log.txt')
      end
    end

  end

end