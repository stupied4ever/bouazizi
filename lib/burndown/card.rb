require 'active_support/core_ext/hash/indifferent_access'

module Burndown
  class Card < Trello::Card

    def initialize fields = {}
      fields = HashWithIndifferentAccess.new fields
      super fields
    end

    def estimative
      estimative = estimatives[:estimative]
      return nil unless estimative
      estimative[/\d+/].to_i
    end

    private

    def estimatives
      estimatives_regex.match(name) || {
        estimative: nil,
        effort:     nil
      }
    end

    def estimatives_regex
        /
          (?<estimative>\((\d+)\)){0}

          \g<estimative>
        /x
    end

  end
end
