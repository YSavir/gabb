module GABB

  class DirectoryMapper

    def self.sessions_path
      Dir.pwd + '/sessions'
    end

    def initialize(options={})
      @session = options[:session] || nil
    end

    def session_path
      Dir.pwd + '/sessions/' + @session.name
    end

  end

end