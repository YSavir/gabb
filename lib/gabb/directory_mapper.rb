module GABB

  class DirectoryMapper

    def initialize(options={})
      @session = options[:session] || nil
    end

    def session_path
      Dir.pwd + '/sessions/' + @session.name
    end

  end

end