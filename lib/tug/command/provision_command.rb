module Tug
  class ProvisionCommand < Command

    def execute(config_file)
      keychain = config_file.keychain

      keychain.create_keychain
      keychain.select_keychain(keychain.name)
      keychain.unlock_keychain
      keychain.set_timeout
      keychain.import_apple_certificate
      keychain.import_distribution_certificate
      keychain.import_private_key
      keychain.import_profile
    end
  end
end