#!/bin/env ruby
#
# % ruby json2distribution_csv.rb protein_molecular_mass_uniprot.json | sort -V
#

require 'json'

JSON[ARGF.read].each do |hash|
  distribution = hash["id"]
  distribution_label = hash["label"]
  distribution_value = hash["value"]
  if distribution_value
    puts [ distribution, distribution_label, distribution_value ].join(",")
  end
end
