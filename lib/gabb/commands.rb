module GABB

  module ConsoleCommands

    def wait(command=nil)
      puts command || "Press Enter to proceed."
      gets.chomp
    end

    def line_break
      puts "===================================="
    end

    def beat
      puts ""
    end

  end

end