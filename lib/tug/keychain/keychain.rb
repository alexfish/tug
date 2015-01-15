module Tug
  class Keychain

    attr_reader :apple_certificate
    attr_reader :distribution_certificate
    attr_reader :distribution_profile
    attr_reader :private_key
    attr_accessor :private_key_password
    attr_accessor :name

    class << self
      def keychain(config)
        if config.has_key?("keychain")
          Tug::Keychain.new(config["keychain"])
        end
      end
    end

    def initialize(keychain_yaml)
      @apple_certificate          = keychain_yaml["apple_certificate"]
      @distribution_certificate   = keychain_yaml["distribution_certificate"]
      @distribution_profile       = keychain_yaml["distribution_profile"]
      @private_key                = keychain_yaml["private_key"]

      # these defaults are also set in Interface
      @private_key_password       = ENV['TUG_P12_PASSWORD']
      @name                       = "tug"
    end

    def configure(options)
      @name = options[:keychain]
      @private_key_password = options[:password]
    end

    def create_keychain
      system("security create-keychain -p tug #{name}.keychain")
    end

    def select_keychain(keychain_name=name)
      system("security default-keychain -s #{keychain_name}.keychain")
    end

    def delete_keychain
      system("security delete-keychain #{name}.keychain")
    end

    def unlock_keychain
      system("security unlock-keychain -p tug #{name}.keychain")
    end

    def set_timeout
      system("security set-keychain-settings -t 3600 -u #{name}.keychain")
    end

    def import_apple_certificate
      system(import_command(apple_certificate))
    end

    def import_distribution_certificate
      system(import_command(distribution_certificate))
    end

    def import_private_key
      system(import_command(private_key) + " -P '#{private_key_password}'")
    end

    def import_profile
      FileUtils.mkdir_p "#{File.expand_path('~')}/Library/MobileDevice/Provisioning\ Profiles/"
      system("cp #{distribution_profile} #{profile_export_path}")
    end

    private

    def profile_export_path
      "#{File.expand_path('~')}/Library/MobileDevice/Provisioning\\ Profiles/"
    end

    def import_command(file)
      "security import #{file} -k #{keychain_path} -T /usr/bin/codesign"
    end

    def keychain_path
      "#{File.expand_path('~')}/Library/Keychains/#{name}.keychain"
    end
  end
end