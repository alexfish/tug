module Tug
  class Keychain

    attr_reader :apple_certificate
    attr_reader :distribution_certificate
    attr_reader :distribution_profile
    attr_reader :private_key
    attr_reader :private_key_password

    def initialize(keychain_yaml)
      @apple_certificate          = keychain_yaml["apple_certificate"]
      @distribution_certificate   = keychain_yaml["distribution_certificate"]
      @distribution_profile       = keychain_yaml["distribution_profile"]
      @private_key                = keychain_yaml["private_key"]
      @private_key_password       = keychain_yaml["private_key_password"]
    end

    def import_apple_certificate
      system("security import #{apple_certificate} -k #{keychain_path} -T /usr/bin/codesign")
    end

    def import_distribution_certificate
      system("security import #{distribution_certificate} -k #{keychain_path} -T /usr/bin/codesign")
    end

    def import_private_key
      system("security import #{private_key} -k #{keychain_path}#{password_option}-T /usr/bin/codesign")
    end

    def import_profile
      FileUtils.cp(distribution_profile, "#{File.expand_path('~')}/Library/MobileDevice/Provisioning\ Profiles/#{profile_name}")
    end

    private

    def profile_name
      distribution_profile.split("/").last
    end
    
    def password_option
      if password
        " -P #{private_key_password} "
      else
        " "
      end
    end

    def keychain_path
      "#{File.expand_path('~')}/Keychains/#{keychain_name}.keychain"
    end

    def keychain_name
      "tug"
    end
  end
end