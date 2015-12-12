require "ghr/version"

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
        prepare
        Release.execute args
      when "feature"
        prepare
        Feature.execute args
      when "hotfix"
        prepare
        Hotfix.execute args
      else
        Helper.help
      end
    end
    
    def prepare
      Helper.exec "git clean -df"
      Helper.exec "git reset --hard"
      Helper.exec "git fetch #{Helper.remotes.first} --prune"
      Helper.exec "git checkout -f #{Helper.master}"
      Helper.exec "git pull origin #{Helper.master}"
      Helper.exec "git checkout -f #{Helper.develop}"
      Helper.exec "git pull origin #{Helper.develop}"
    end
  end
end
