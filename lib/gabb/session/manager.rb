module GABB

  module Session

    module Manager

      def self.session_names
        sessions_path = DirectoryMapper.sessions_path
        Dir.entries(sessions_path).select do |entry|
          File.directory? sessions_path + '/' + entry
        end.reject do |folder|
          ['.', '..'].include? folder
        end
      end

      def self.session_exists?(session_name)
        session_names.include? session_name
      end

      def self.create_session(session_name)
        session_path = DirectoryMapper.sessions_path + '/' + session_name
        FileUtils.mkdir(session_path)
        FileUtils.touch(session_path + '/log.txt')
      end
    end
  end
end