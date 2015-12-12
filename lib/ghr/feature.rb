# encoding: utf-8

module GHR
  module Feature
    class << self
      def execute args
        subcommand = args.shift
        name = args.shift
        
        raise "name must specified." if name.empty?
        
        case subcommand
        when "start"
          start name
        when "finish"
          finish name
        else
          help
        end
      end

      def start name, options = {}
        branch = GHR::Helper.branch "feature", name
        GHR::Helper.exec("git flow feature start #{name}", true)
      end
      
      def finish name, options = {}
        branch = GHR::Helper.branch "feature", name
        GHR::Helper.exec("git flow feature finish #{name}", true)
      end
      
      def help
        help = <<HELP
usage: ghr release <subcommand> version

Available subcommands are:
   start   release start
   freeze  release freeze (non git-flow operation)
   finish  release finish
HELP

        puts help
      end
    end
  end
end
