require "ghr/commands/version"

module GHR
  autoload :Helper, 'ghr/helper'
  autoload :Release, 'ghr/release'
  autoload :Feature, 'ghr/feature'
  autoload :Hotfix, 'ghr/hotfix'

  class << self
    def execute args
      raise "You need to run this command from the toplevel of the working tree." unless Helper.root?
      raise "You need to run `git flow init` before operation." unless Helper.inited?

      subcommand = args.shift

      case subcommand
      when "release"
        Release.execute args
      when "feature"
        Feature.execute args
      when "hotfix"
        Hotfix.execute args
      else
        Helper.help
      end
    end
  end
end
