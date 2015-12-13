# encoding: utf-8

module GHR
  module Github
    class << self
    end

    module PullRequests
      class << self
        def create base, head, title, body = nil
        end

        def find base, head
        end
      end
    end
  end
end
