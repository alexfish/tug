module Tug
  class ProtectedKeychain < Keychain

    def import_private_key
      system(import_command(private_key) + " -P #{private_key_password}")
    end
  end
end