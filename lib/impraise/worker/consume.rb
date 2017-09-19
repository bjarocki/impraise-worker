# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    class Consume
      def initialize
        @config = Impraise::Worker::Config.new
        @dns = Impraise::Worker::DNS
        @logger = Impraise::Worker::Logger.new
        disque_host, disque_port = @dns.disco('disque')
        @client = Disque.new("#{disque_host}:#{disque_port}", cycle: 20_000)
      end

      def justdoit(path)
        s = File.stat(path)
        @logger.publish(path: path, size: s.size, mtime: s.mtime, ctime: s.ctime)
      end

      def run
        loop do
          @client.fetch(from: @config.get('DISQUE_QUEUE').split(',')) do |job|
            yield job
          end
        end
      end
    end
  end
end
