#!/bin/env ruby
#
# cat gene_chromosome_ensembl.json | jq -r '.[] | [.id, .label, .parent, .leaf] | @csv'
# ruby gene_chromosome_ensembl.rb gene_chromosome_ensembl.json | sort -V > gene_chromosome_ensembl.csv
#

require 'json'

JSON[ARGF.read].each do |hash|
  classification = hash["id"]
  classification_label = hash["label"]
  classification_parent = hash["parent"]
  leaf = hash["leaf"] == true ? 1 : 0
  # remove patch sequences
  regex = /^(root|\d|X|Y|MT|ENSG)/
  if classification and classification[regex] and classification_parent and classification_parent[regex]
    puts [ classification, classification_label, classification_parent, leaf ].join(",")
  elsif ! classification_parent
    puts ",root,root node,,0"
  end
end
