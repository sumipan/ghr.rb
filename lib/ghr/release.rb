# encoding: utf-8

module GHR
  module Release
    class << self
      def execute args
        subcommand = args.shift
        
        case subcommand
        when "start"
          puts GHR::Helper.exec("echo start")
        when "finish"
          puts GHR::Helper.exec("echo finish")
        when "publish"
          puts GHR::Helper.exec("echo publish")
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
