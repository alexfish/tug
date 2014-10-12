module Tug

  class Deploy < Thor

    desc "testflight", "deploy an ipa to testflight"
    option :file,
           :aliases => "-f",
           :default => Dir.glob("*.ipa").first
    option :dsym,
           :aliases => "-d",
           :default => Dir.glob("*.dSYM.zip").first
    option :api_token,
           :aliases => "-a",
           :default => ENV['TUG_TESTFLIGHT_API_TOKEN']
    option :team_token,
           :aliases => "-t",
           :default => ENV['TUG_TESTFLIGHT_TEAM_TOKEN']
    option :lists,
           :aliases => "-l"
    option :notify,
           :aliases => "-n",
           :default => false
    option :release_notes,
           :aliases => "-r",
           :default => "This build was uploaded via Tug"
    def testflight
      deployer = Tug::Testflight.new(options)
      deployer.deploy
    end

    desc "hockeyapp", "deploy an ipa to hockeyapp"
    option :file,
           :aliases => "-f",
           :default => Dir.glob("*.ipa").first
    option :dsym,
           :aliases => "-d",
           :default => Dir.glob("*.dSYM.zip").first
    option :api_token,
           :aliases => "-a",
           :default => ENV['TUG_HOCKEYAPP_API_TOKEN']
    option :notify,
           :aliases => "-n",
           :default => 0
    option :release_notes,
           :aliases => "-r",
           :default => "This build was uploaded via Tug"
    option :notes_type,
           :aliases => "-y",
           :default => 1
    option :status,
           :aliases => "-s"
    option :tags,
           :aliases => "-t"
    option :teams,
           :aliases => "-e"
    option :users,
           :aliases => "-u"
    option :mandatory,
           :aliases => "-m"
    option :release_type,
           :aliases => "-l",
           :default => 0
    option :private,
           :aliases => "-p",
           :default => false
    option :commit_sha,
           :aliases => "-h"
    option :build_server_url,
           :aliases => "-u"
    option :repository_url,
           :aliases => "-p"
    def hockeyapp
      deployer = Tug::Hockeyapp.new(options)
      deployer.deploy
    end

    no_commands do
      def execute(config_file)
        command = Tug::Command.command_for_string("deploy")
        command.execute(config_file)
      end
    end
  end
end
