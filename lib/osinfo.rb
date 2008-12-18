$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module OsInfo
  VERSION = '0.0.1'

  def detect
    if File.exists?("/proc/version")
      return OsInfo::Linux.new
    elsif `sw_vers`.length != 0
      return OsInfo::Macintosh.new
    elsif RUBY_PLATFORM =~ /(win|w)32$/
      return OsInfo::Windows.new
    else
      return OsInfo::OperatingSystem.new
    end
  end
end
