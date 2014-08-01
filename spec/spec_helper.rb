require "tug"

module Helpers
  def project_yaml
    {"project" => {"workspace" => "workspace",
      "schemes" => ["scheme"],
      "ipa_config" => "config",
      "ipa_profile" => "profile"}}
  end

  def keychain_yaml
    {"keychain" => {"apple_certificate" => "apple", 
            "distribution_certificate" => "dist", 
            "distribution_profile" => "path/to/profile", 
            "private_key" => "private"}}
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'output.txt'), 'w')
  end
  config.include Helpers
end