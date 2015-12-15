# encoding: utf-8

module GHR
  module Release
    class << self
      def execute args
        subcommand = args.shift
        version = args.shift

        raise "version must be number." unless version.to_i > 0

        branch = GHR::Helper.branch "release", version

        case subcommand
        when "start"
          start version
          GHR::Helper.empty_commit "Start release #{version}"
          publish version
          sleep 5 # wait sync github
          GHR::Github::PullRequests.create branch, GHR::Helper.develop, "[RELEASE] Develop #{version}", ""
        when "freeze"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          freeze version
        when "finish"
          if !GHR::Github::PullRequests.mergeable? GHR::Helper.master, branch then
            GHR::Helper.help_cant_merge
            exit 1
          end
          GHR::Helper.exec("git checkout -f #{branch}", true)
          finish version
          GHR::Helper.exec("git push #{GHR::Helper.remotes.first} #{GHR::Helper.master}:#{GHR::Helper.master}")
          GHR::Helper.exec("git push #{GHR::Helper.remotes.first} :#{branch}")
        when "publish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          publish version
          GHR::Helper.exec("git push #{Helper.remotes.first} #{branch}:#{branch}", true)
        else
          help
        end
      end

      def start version, options = {}
        GHR::Helper.exec("git flow release start #{version}", true)
      end

      # non git-flow operation
      # Code freeze needed
      def freeze version, options = {}
      end

      def finish version, options = {}
        # -n no tag
        # -p push origin
        # -m message
        GHR::Helper.exec("git flow release finish -np -m 'release:finish' #{version}", true)

        # GHR::Helper.exec("git checkout -f #{GHR::Helper.develop}")
        # GHR::Helper.exec("git merge #{GHR::Helper.master}")
        # GHR::Helper.exec("git push #{GHR::Helper.remotes.first} #{GHR::Helper.develop}:#{GHR::Helper.develop}")
      end

      def publish version, options = {}
        GHR::Helper.exec("git flow release publish #{version}", true)
      end

      def help
        help = <<HELP
usage: ghr release <subcommand> version

Available subcommands are:
   start   release start
   publish release publish
   freeze  release freeze (non git-flow operation)
   finish  release finish
HELP

        puts help
      end
    end
  end
end
