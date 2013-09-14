require 'active_support/core_ext/hash/indifferent_access'

module Bouazizi
  class Card < Trello::Card

    def initialize fields = {}
      fields = HashWithIndifferentAccess.new fields
      super fields
    end

    def metrics
      if metrics = metrics_regex.match(name)
        metrics.names.inject(HashWithIndifferentAccess.new){ |hash, e|

          hash.store e, metrics[e][/\d+/].to_i unless metrics[e].nil?
          hash
        }
      else
        Hash.new
      end
    end

    def metrics_regex
        /
          (?<real_effort>\[(\d+)\]){0}
          (?<estimative>\((\d+)\)){0}

          \g<real_effort>? \g<estimative>?
        /x
    end
  end
end
