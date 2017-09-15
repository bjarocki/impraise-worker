# frozen_string_literal: true

require 'impraise/worker/requirements'

module Impraise
  module Worker
    class Config
      def get(key)
        ENV.to_hash.dig(key)
      end
    end
  end
end
