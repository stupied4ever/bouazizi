require 'active_support/core_ext/hash/indifferent_access'

module Burndown
  class Card < Trello::Card

    def initialize fields = {}
      fields = HashWithIndifferentAccess.new fields
      super fields
    end

    def estimatives
      if estimatives = estimatives_regex.match(name)
        estimatives.names.inject(HashWithIndifferentAccess.new){ |hash, e|

          hash.store e, estimatives[e][/\d+/].to_i unless estimatives[e].nil?
          hash
        }
      else
        Hash.new
      end
    end

    def estimatives_regex
        /
          (?<real_effort>\[(\d+)\]){0}
          (?<estimative>\((\d+)\)){0}

          \g<real_effort>? \g<estimative>?
        /x
    end

  end
end
