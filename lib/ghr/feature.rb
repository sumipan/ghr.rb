# encoding: utf-8

module GHR
  module Feature
    class << self
      def execute args
        subcommand = args.shift
        name = args.shift

        raise "name must specified." if !name || name.empty?

        branch = GHR::Helper.branch "feature", name

        case subcommand
        when "start"
          start name
          publish name
          GHR::Github::PullRequests.create GHR::Helper.develop, branch, "[FEATURE] #{name}", ""
        when "finish"
          if !GHR::Github::PullRequests.mergeable? GHR::Helper.develop, branch then
            GHR::Helper.help_cant_merge
            exit 1
          end
          GHR::Helper.exec("git checkout -f #{branch}", true)
          finish name
        when "publish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          publish name
          GHR::Helper.exec("git push #{Helper.remotes.first} #{branch}:#{branch}", true)
        else
          help
        end
      end

      def start name, options = {}
        GHR::Helper.exec("git flow feature start #{name}", true)
      end

      def publish name, options = {}
        GHR::Helper.exec("git flow feature publish #{name}", true)
      end

      def finish name, options = {}
        branch = GHR::Helper.branch "feature", name
        GHR::Helper.exec("git flow feature finish #{name}", true)
      end

      def help
        help = <<HELP
usage: ghr feature <subcommand> name

Available subcommands are:
   start   feature start
   finish  feature finish
HELP

        puts help
      end
    end
  end
end
