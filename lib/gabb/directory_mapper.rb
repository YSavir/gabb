module GABB

  module DirectoryMapper

    def self.sessions_path
      Dir.pwd + '/sessions'
    end

    def self.session_path_for(session)
      Dir.pwd + '/sessions/' + session.name
    end
  end
end