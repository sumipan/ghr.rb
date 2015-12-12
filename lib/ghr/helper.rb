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
      
      def master
        branch = exec "git config gitflow.branch.master"
        raise "no gitflow config found." if branch.empty?
        
        branch
      end
      
      def develop
        branch = exec "git config gitflow.branch.develop"
        raise "no gitflow config found." if branch.empty?
        
        branch
      end

      def branch type, name
        case type
        when "release"
          prefix = exec "git config gitflow.prefix.release"
        when "feature"
          prefix = exec "git config gitflow.prefix.feature"
        when "hotfix"
          prefix = exec "git config gitflow.prefix.hotfix"
        end

        raise "no gitflow config found." if prefix.empty?
        
        prefix + name
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
