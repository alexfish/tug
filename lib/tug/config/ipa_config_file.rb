module Tug
  class IpaConfigFile < ConfigFile

    class << self

      def config_file(options)
        config_file = config_file_from_path(options[:config])
        config_file.project.ipa_export_path = options[:export]
        config_file.project.ipa_config = options[:build_config]

        return config_file
      end
    end
  end
end