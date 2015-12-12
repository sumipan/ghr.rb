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
    end
  end
end
