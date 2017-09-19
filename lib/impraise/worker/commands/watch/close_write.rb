# frozen_string_literal: true

module Impraise
  module Worker
    module Commands
      class Watch < Thor
        include INotify
        desc 'close-write', 'Watch for close_write events and emit queue jobs'

        def close_write
          watch = Impraise::Worker::Watch.new
          notifier = INotify::Notifier.new

          # close_write is an event emited just after we got file uploaded
          #  and ready to proces. Sounds like exactly what we need here :)
          notifier.watch(watch.directory, :close_write, :recursive) do |event|
            watch.job(event.absolute_name)
          end

          notifier.run
        end
      end
    end
  end
end
