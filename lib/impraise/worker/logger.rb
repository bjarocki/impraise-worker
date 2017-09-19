# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    class Logger
      def initialize
        @config = Impraise::Worker::Config.new
        @dns = Impraise::Worker::DNS

        # discover redis service and setup client
        host, port = @dns.disco('redis')
        @redis = ::Redis.new(host: host, port: port, db: 0)
      end

      def channel
        'impraise-debug'
      end

      def publish(message)
        @redis.publish(channel, sanitize(hostname: Socket.gethostname, body: message))
      end

      private

      def sanitize(message)
        json = JSON.parse(JSON.generate(message))
        json.each { |key, value| json[key] = ERB::Util.html_escape(value) }
        JSON.generate(json)
      end
    end
  end
end
