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
          publish version
        when "publish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          publish version
          GHR::Helper.exec("git push #{Helper.remotes.first} #{branch}:#{branch}", true)
        when "freeze"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          freeze version
        when "finish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          finish version
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
