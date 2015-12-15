# encoding: utf-8

require "ghr/version"
require "github_api"

module GHR
  autoload :Helper, 'ghr/helper'
  autoload :Release, 'ghr/release'
  autoload :Feature, 'ghr/feature'
  autoload :Hotfix, 'ghr/hotfix'
  autoload :Github, 'ghr/github'

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

    def client
      unless @github then
        if !Helper.token || Helper.token.empty?
          Helper.help_authorize
          exit 1
        end

        @github = ::Github::Client.new
        @github.setup({
          :user => Helper.user,
          :repo => Helper.repo,
          :oauth_token => Helper.token,
        })
      end

      @github
    end

    def prepare
      Helper.exec "git clean -df", true
      Helper.exec "git reset --hard", true
      Helper.exec "git fetch #{Helper.remotes.first} --prune", true
      Helper.exec "git checkout -f #{Helper.master}", true
      Helper.exec "git pull origin #{Helper.master}", true
      Helper.exec "git checkout -f #{Helper.develop}", true
      Helper.exec "git pull origin #{Helper.develop}", true
    end
  end
end
