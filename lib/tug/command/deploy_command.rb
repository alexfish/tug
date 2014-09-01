module Tug
  class DeployCommand < Command

    def execute(config_file)
      deployer = Tug::Deployer.deployer(config_file)
      deployer.deploy
    end
  end
end