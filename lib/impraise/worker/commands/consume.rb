# frozen_string_literal: true

require 'impraise/worker/commands/consume/jobs'

module Impraise
  module Worker
    module Commands
      class Consume < Thor
        include Thor::Actions
      end
    end
  end
end
