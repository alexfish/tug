module Tug
  class Keychain

    attr_reader :apple_certificate
    attr_reader :distribution_certificate
    attr_reader :distribution_profile
    attr_reader :private_key
    attr_reader :private_key_password
    attr_accessor :name

    class << self
      def keychain(keychain_yaml)
        if keychain_yaml and keychain_yaml.has_key? "private_key_password"
          Tug::ProtectedKeychain.new(keychain_yaml)
        elsif keychain_yaml
          Tug::Keychain.new(keychain_yaml)
        end
      end
    end

    def initialize(keychain_yaml)
      @apple_certificate          = keychain_yaml["apple_certificate"]
      @distribution_certificate   = keychain_yaml["distribution_certificate"]
      @distribution_profile       = keychain_yaml["distribution_profile"]
      @private_key                = keychain_yaml["private_key"]
      @private_key_password       = keychain_yaml["private_key_password"]
      @name                       = "tug"
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

    def import_apple_certificate
      system(import_command(apple_certificate))
    end

    def import_distribution_certificate
      system(import_command(distribution_certificate))
    end

    def import_private_key
      system(import_command(private_key) + " -P ''")
    end

    def import_profile
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