# encoding: utf-8

module GHR
  module Helper
    
    class << self

      def inited?
        return !exec('git config gitflow.branch.master').strip.empty?
      end
      
      def root?
        return File.exist?('.git/config')
      end

      def exec(command)
        return `#{command} 2>/dev/null`.chomp
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
    end
  end
end
