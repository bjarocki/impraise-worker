# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    class RethinkDB
      include ::RethinkDB::Shortcuts

      def table_name
        'logs'
      end

      def db_name
        'impraise'
      end

      def notify(object)
        r.table(table_name).insert(object).run
      end

      # rubocop:disable Metrics/AbcSize
      def initialize
        @config = Impraise::Worker::Config.new
        @dns = Impraise::Worker::DNS

        # discover rethinkdb service
        host, port = @dns.disco('rethinkdb')

        # connect and make sure both db and table exist
        r.connect(host: host, port: port).repl
        r.db_create(db_name).run unless r.db_list.run.include? db_name
        r.db(db_name).table_create(table_name).run unless r.db(db_name).table_list.run.include? table_name
        @client = r.connect(host: host, port: port, db: db_name).repl
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
