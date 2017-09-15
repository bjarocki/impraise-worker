# frozen_string_literal: true

module Impraise
  module Worker
    module Commands
      class Watch < Thor
        include INotify
        desc 'close-write', 'Watch for close_write events'

        def close_write
          watch = Impraise::Worker::Watch.new
          notifier = INotify::Notifier.new
          notifier.watch(watch.directory, :close_write, :recursive) do |event|
            watch.job(event.absolute_name)
          end
          notifier.run
        end
      end
    end
  end
end
