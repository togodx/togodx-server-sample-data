#!/bin/env ruby
#
# % ruby json2classification_csv.rb gene_high_level_expression_refex.json | sort -V > gene_high_level_expression_refex.csv
# % ruby json2classification_csv.rb gene_transcription_factors_chip_atlas.json | sort -V > gene_transcription_factors_chip_atlas.csv
# % ruby json2classification_csv.rb protein_cellular_component_uniprot.json | sort -V > protein_cellular_component_uniprot.csv
# % ruby json2classification_csv.rb protein_disease_related_proteins_uniprot.json | sort -V > protein_disease_related_proteins_uniprot.csv
#

require 'json'

def escape(str)
  return '"' + str + '"'
end

JSON[ARGF.read].each do |hash|
  classification = hash["id"]
  classification_label = escape(hash["label"])
  classification_parent = hash["parent"]
  leaf = hash["leaf"] == true ? 1 : 0
  puts [ classification, classification_label, classification_parent, leaf ].join(",")
end
