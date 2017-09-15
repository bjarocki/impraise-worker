# frozen_string_literal: true

require 'impraise/worker/commands/watch/close_write'

module Impraise
  module Worker
    module Commands
      class Watch < Thor
        include Thor::Actions
      end
    end
  end
end
