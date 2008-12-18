module OsInfo
  class Unix < OsInfo::OperatingSystem
    def initialize
      @user = `whoami`.chop
    end
  end
end
