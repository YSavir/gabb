module GABB

  class Session

    def initialize(options={})
      @name = options[:name] || Time.now.to_s
      if options[:new] then puts 'hi' end
      @directory = Dir.new("sessions/" + name)
    end

    def new_session_directory
      dir_name = './sessions/' + @name
      FileUtils.mkdir(dir_name) unless Dir.exists?(dir_name)
    end

  end

end