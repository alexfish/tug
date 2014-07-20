require "tug"

module Helpers
  def project_yaml
    {"workspace" => "workspace",
      "schemes" => ["scheme"],
      "ipa_config" => "config",
      "ipa_profile" => "profile"}
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
  end
  config.include Helpers
end