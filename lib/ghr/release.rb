# encoding: utf-8

module GHR
  module Release
    class << self
      def execute args
        subcommand = args.shift
        
        case subcommand
        when "start"
        when "finish"
        when "publish"
        else
          help
        end
      end

      def start version, options = {}
        GHR::Helper.exec("git flow release start -F #{version}")
      end
      
      def finish version, options = {}
      end
      
      def publish version, options = {}
      end
      
      def help
        help = <<HELP
usage: ghr release <subcommand> version

Available subcommands are:
   start   release start
   finish  release finish
   publish release publish
HELP

        puts help
      end
    end
  end
end
