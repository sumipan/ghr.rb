# encoding: utf-8

require "open3"

module GHR
  module Helper
    
    class << self

      def inited?
        return !exec('git config gitflow.branch.master').strip.empty?
      end
      
      def root?
        return File.exist?('.git/config')
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
    end
  end
end
