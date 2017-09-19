# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    class Watch
      def initialize
        @config = Impraise::Worker::Config.new
        @dns = Impraise::Worker::DNS
        disque_host, disque_port = @dns.disco('disque')
        @queue = Disque.new("#{disque_host}:#{disque_port}", cycle: 20_000)
      end

      # push a job into the queue
      def job(body)
        @queue.push(@config.get('DISQUE_QUEUE'), body, 1000)
      end

      # get watch directory path or die ;(
      def directory
        @config.get('WATCH_DIRECTORY') || abort('Missing WATCH_DIRECTORY')
      end
    end
  end
end
