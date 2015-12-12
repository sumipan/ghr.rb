# encoding: utf-8

module GHR
  module Commands
    autoload :Release, 'ghr/commands/release'
    autoload :Feature, 'ghr/commands/feature'
    autoload :Hotfix, 'ghr/commands/hotfix'

    class << self
    end
  end
end
