module Tug
  class KeychainConfigFile < ConfigFile

    class << self

      def config_file(options)
        config_file = config_file_from_path(options[:config])
        config_file.keychain.name = options[:keychain]
        config_file.keychain.private_key_password = options[:password]

        return config_file
      end
    end
  end
end