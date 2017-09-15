# frozen_string_literal: true

module Impraise
  module Worker
    module Commands
      class Consume < Thor
        desc 'jobs', 'Consume job'

        def jobs
          consume = Impraise::Worker::Consume.new
          consume.run do |path|
            consume.justdoit(path)
          end
        end
      end
    end
  end
end
