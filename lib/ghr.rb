require "ghr/commands/version"

module GHR
  module Commands
    # Your code goes here...
  end
  autoload :Helper, 'ghr/helper'
  autoload :Commands, 'ghr/commands'

  class << self
    def execute args
      raise "You need to run this command from the toplevel of the working tree." unless Helper.root?
      raise "You need to run `git flow init` before operation." unless Helper.inited?

      subcommand = args.shift

      case subcommand
      when "release"
      when "feature"
      when "hotfix"
      else
        Helper.help
      end
    end
  end
end
