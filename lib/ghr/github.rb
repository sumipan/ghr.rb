# encoding: utf-8

module GHR
  module Github
    class << self
    end

    module PullRequests
      class << self
        def create base, head, title, body = ""
          pull_request = GHR.client.pull_requests.create({
            :base  => base,
            :head  => head,
            :title => title,
            :body  => body,
          }).body

          pull_request
        end

        def mergeable? base, head
          pull_request = find base, head
          raise "no pull_request found." unless pull_request

          pull_request.mergeable == true
        end

        def find base, head
          pull_requests = GHR.client.pull_requests.list({
            :base  => base,
            :head  => head,
          }).body

          if pull_requests && pull_requests.size > 0 then
            return GHR.client.pull_requests.get({ :number => pull_requests.first.number }).body
          else
            return nil
          end
        end
      end
    end
  end
end
