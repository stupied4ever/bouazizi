require 'active_support/core_ext/hash/indifferent_access'

module Burndown
  class Card < Trello::Card

    def initialize fields = {}
      fields = HashWithIndifferentAccess.new fields
      super fields
    end

    def estimative
      name[/\d/].to_i
    end

  end
end
