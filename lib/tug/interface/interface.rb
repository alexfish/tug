module Tug

  class Deploy < Thor

    desc "testflight", "deploy an ipa to testflight"
    option :file, :aliases => "-f", :default => Dir.glob("*.ipa").first
    option :config, :default => "#{Dir.pwd}/.tug.yml", :aliases => "-c"
    option :api_token, :aliases => "-a", :default => ENV['TUG_TESTFLIGHT_API_TOKEN']
    option :team_token, :aliases => "-t", :default => ENV['TUG_TESTFLIGHT_TEAM_TOKEN']
    option :lists, :aliases => "-l"
    option :notify, :aliases => "-n", :default => false
    def testflight
      deployer = Tug::Deployer.deployer(options)
      deployer.deploy
    end

    no_commands do
      def execute(config_file)
        command = Tug::Command.command_for_string("deploy")
        command.execute(config_file)
      end
    end
  end

  class Interface < Thor

    desc "build", "build a project"
    option :config, :default => "#{Dir.pwd}/.tug.yml", :aliases => "-c"
    def build
      config_file = Tug::ConfigFile.config_file(options[:config])
      execute(__method__.to_s, config_file)
    end

    desc "ipa", "generate an ipa"
    option :config, :default => "#{Dir.pwd}/.tug.yml", :aliases => "-c"
    option :export, :default => "#{Dir.pwd}", :aliases => "-e"
    def ipa
      config_file = Tug::ConfigFile.config_file(options[:config])
      config_file.project.ipa_export_path = options[:export]
      execute(__method__.to_s, config_file)
    end

    desc "provision", "provision system distrubution certificates and provisioning profile"
    option :config, :default => "#{Dir.pwd}/.tug.yml", :aliases => "-c"
    option :keychain, :default => "tug", :aliases => "-k"
    option :password, :aliases => "-p", :default => ENV['TUG_P12_PASSWORD']
    def provision
      config_file = Tug::ConfigFile.config_file(options[:config])
      config_file.keychain.name = options[:keychain]
      config_file.keychain.private_key_password = options[:password]
      execute(__method__.to_s, config_file)
    end

    desc "deploy", "deploy an ipa to an external service"
    subcommand "deploy", Deploy

    no_commands do
      def execute(command, config_file)
        command = Tug::Command.command_for_string(command)
        command.execute(config_file)
      end
    end
  end
end