module Tug
  class DeployCommand < Command

    def execute(config_file)
      deployer = config_file.deployer
      deployer.deploy
    end
  end
end