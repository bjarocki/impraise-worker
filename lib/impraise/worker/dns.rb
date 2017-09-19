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

      # check for DOMAIN_DISCO env variable or fallback to service.consul
      def self.domain_disco
        if ENV.include? 'DOMAIN_DISCO'
          ENV['DOMAIN_DISCO']
        else
          'service.consul'
        end
      end

      def self.disco(service)
        # check for disco environment as a service discovery fallback
        de = "DISCO_#{service}".upcase
        return ENV[de].split(':') if ENV.include? de

        # let's give those services some time to register before we decide it's gone
        30.times do
          host, port = srv("#{service}.#{domain_disco}").first
          return [host, port] if host && port
          sleep(1)
        end
        abort("Couldn't discover #{service}")
      end
    end
  end
end
