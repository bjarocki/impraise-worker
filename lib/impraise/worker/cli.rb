# frozen_string_literal: true

require 'impraise/worker/requirements'
require 'impraise/worker/helpers'
require 'impraise/worker/commands'
require 'impraise/worker/version'

module Impraise
  module Worker
    class CLI < Thor
      desc 'version', 'Show version'
      def version
        puts Impraise::Worker::VERSION
      end

      desc 'watch', 'Watch for inotify events'
      subcommand 'watch', Impraise::Worker::Commands::Watch

      desc 'consume', 'Me likey consume'
      subcommand 'consume', Impraise::Worker::Commands::Consume
    end
  end
end
