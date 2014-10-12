module GABB

  module Commands

    def wait(command=nil)
      puts command || "Press Enter to proceed."
      gets.chomp
    end

  end

end