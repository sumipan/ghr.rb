# encoding: utf-8

module GHR
  module Release
    class << self
      def execute args
        subcommand = args.shift
        version = args.shift
        
        raise "version must be number." unless version.to_i > 0
        
        case subcommand
        when "start"
          start version
        when "finish"
          finish version
        when freeze
          freeze version
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
        GHR::Helper.exec("git flow release finish -Fnp -m 'release:finish' #{version}")
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
