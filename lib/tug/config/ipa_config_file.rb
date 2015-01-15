module Tug
  class IpaConfigFile < ConfigFile

    class << self

      def config_file(options)
        config_file = config_file_from_path(options[:config])
        config_file.project.configure(options)

        return config_file
      end
    end
  end
end