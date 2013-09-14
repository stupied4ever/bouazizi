require 'active_support/core_ext/hash/indifferent_access'

module Burndown
  class Card < Trello::Card

    def initialize fields = {}
      fields = HashWithIndifferentAccess.new fields
      super fields
    end

    def estimative
      estimatives[:estimative]
    end

    private

    def estimatives
      if estimatives = estimatives_regex.match(name)
        estimatives.names.inject(HashWithIndifferentAccess.new){ |hash, e|
          hash.store e, estimatives[e][/\d+/].to_i
          hash
        }
      else
        Hash.new(nil)
      end
    end

    def estimatives_regex
        /
          (?<estimative>\((\d+)\)){0}

          \g<estimative>
        /x
    end

  end
end
