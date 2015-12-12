require "ghr/commands/version"

module GHR
  module Commands
    # Your code goes here...
  end
  autoload :Helper, 'ghr/helper'

  class << self
    def execute args
      raise "You need to run this command from the toplevel of the working tree." unless Helper.root?
      raise "You need to run `git flow init` before operation." unless Helper.inited?

    end
  end
end
