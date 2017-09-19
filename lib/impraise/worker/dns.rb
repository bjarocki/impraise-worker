# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    module DNS
      def self.srv(name)
        query = Resolv::DNS.new
        hosts = query.getresources(name,
                                   Resolv::DNS::Resource::IN::SRV)
        hosts.map do |host|
          [host.target.to_s, host.port]
        end
      end

      def self.disco(service)
        # check for disco environment as a service discovery fallback
        de = "DISCO_#{service}".upcase
        return ENV[de].split(':') if ENV.include? de

        30.times do
          host, port = srv("#{service}.service.consul").first
          return [host, port] if host && port
          sleep(1)
        end
        abort("Couldn't discover #{service}")
      end
    end
  end
end
