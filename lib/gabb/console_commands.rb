module GABB

  module ConsoleCommands

    def wait(command=nil)
      puts command || "Press Enter to proceed."
      gets.chomp
    end

    def line_break
      puts "==========================================="
    end

    def beat
      puts ""
    end

    def clear_screen
      system("clear")
    end
  end
end