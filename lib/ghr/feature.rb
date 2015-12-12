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
        when "finish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          finish name
        when "publish"
          GHR::Helper.exec("git checkout -f #{branch}", true)
          publish name
        else
          help
        end
      end

      def start name, options = {}
        GHR::Helper.exec("git flow feature start #{name}", true)
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
   publish feature publish
   finish  feature finish
HELP

        puts help
      end
    end
  end
end
