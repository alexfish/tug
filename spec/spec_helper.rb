require "tug"

RSpec.configure do |config|
  config.before(:suite) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
  end
end