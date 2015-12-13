# encoding: utf-8

require "open3"

module GHR
  module Helper

    class << self

      def inited?
        return !exec('git config gitflow.branch.master').strip.empty?, true
      end

      def github_url_detect
        url = exec "git config remote.#{remotes.first}.url", true
        raise "no remote config found." unless url

        match = url.match(/github\.com[:\/](.+)\/(.+)\.git$/)
        raise "no github url match." unless match

        match
      end

      def user
        github_url_detect[1]
      end

      def repo
        github_url_detect[2]
      end

      def token
        exec "git config --local ghr.token"
      end

      def root?
        return File.exist?('.git/config')
      end

      def remotes
        remotes = exec "git remote"
        remotes.each_line.map{|l| l.strip }
      end

      def master
        branch = exec "git config gitflow.branch.master"
        raise "no gitflow config found." if branch.empty?

        branch
      end

      def develop
        branch = exec "git config gitflow.branch.develop"
        raise "no gitflow config found." if branch.empty?

        branch
      end

      def branch type, name
        case type
        when "release"
          prefix = exec "git config gitflow.prefix.release"
        when "feature"
          prefix = exec "git config gitflow.prefix.feature"
        when "hotfix"
          prefix = exec "git config gitflow.prefix.hotfix"
        end

        raise "no gitflow config found." if prefix.empty?

        prefix + name
      end

      def exec command, raise_error = false
        if raise_error then
          stdout, stderr, status = Open3.capture3 command
          if status.exitstatus != 0 then
            puts stderr.chomp
            raise "command exec fail `#{command}`"
          end

          return stdout.chomp
        else
          return `#{command} 2>/dev/null`.chomp
        end
      end

      def help
        help = <<HELP
usage: ghr <subcommand>

Available subcommands are:
   feature   Manage your feature branches.
   release   Manage your release branches.
   hotfix    Manage your hotfix branches.

Try 'ghr <subcommand> help' for details.
HELP
        puts help
      end

      def help_authorize
        help = <<HELP
Github access_token required.

`git config --local ghr.token <your access token>`
HELP
        puts help
      end

      def help_cant_merge
        help = <<HELP
pull_request is not mergable. check your branch status.
HELP
        puts help
      end
    end
  end
end
