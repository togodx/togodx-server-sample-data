#!/usr/bin/env ruby

def set_csv_load_mode
  puts ".mode csv"
end

CREATE_CLASSIFICATIONS_TMP_TABLE = <<END
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
END

CREATE_CLASSIFICATIONS_IDX_TABLE = <<END
CREATE TABLE IF NOT EXISTS "table1" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table1_on_classification" ON "table1" ("classification");
CREATE INDEX "index_table1_on_leaf" ON "table1" ("leaf");
CREATE INDEX "index_table1_on_parent_id" ON "table1" ("parent_id");
CREATE INDEX "index_table1_on_lft" ON "table1" ("lft");
CREATE INDEX "index_table1_on_rgt" ON "table1" ("rgt");
END

CREATE_DISTRIBUTIONS_TMP_TABLE = <<END
CREATE TABLE IF NOT EXISTS "distributions_tmp" ("distribution" varchar NOT NULL, "distribution_label" varchar, "distribution_value" float NOT NULL);
END

CREATE_DISTRIBUTIONS_IDX_TABLE = <<END
CREATE TABLE IF NOT EXISTS "table1" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "distribution" varchar NOT NULL, "distribution_label" varchar, "distribution_value" float NOT NULL);
CREATE INDEX "index_table1_on_distribution" ON "table1" ("distribution");
CREATE INDEX "index_table1_on_distribution_value" ON "table1" ("distribution_value");
END

UPDATE_CLASSIFICATIONS_ROOT_ID = <<END
UPDATE table1 SET parent_id = NULL WHERE parent_id = "";
END

UPDATE_CLASSIFICATIONS_PARENT_ID = <<END
UPDATE table1
SET parent_id = (
  SELECT parent.id
  FROM table1 parent
  WHERE table1.classification_parent = parent.classification
)
WHERE EXISTS(
  SELECT 1
  FROM table1 parent
  WHERE table1.classification_parent = parent.classification
  AND table1.classification_parent IS NOT NULL
);
END

def create_classifications_tmp
  puts CREATE_CLASSIFICATIONS_TMP_TABLE
end

def create_distributions_tmp
  puts CREATE_DISTRIBUTIONS_TMP_TABLE
end

def create_classifications_idx(table)
  puts CREATE_CLASSIFICATIONS_IDX_TABLE.gsub("table1", table)
end

def create_distributions_idx(table)
  puts CREATE_DISTRIBUTIONS_IDX_TABLE.gsub("table1", table)
end

def import_classifications_tmp(csv)
  puts ".import #{csv} classifications_tmp"
end

def import_distributions_tmp(csv)
  puts ".import #{csv} distributions_tmp"
end

def copy_classifications_tmp_to_idx(table)
  puts "INSERT INTO #{table} SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;"
end

def copy_distributions_tmp_to_idx(table)
  puts "INSERT INTO #{table} SELECT NULL,* FROM distributions_tmp;"
end

def drop_classifications_tmp
  puts "DROP TABLE classifications_tmp;"
end

def drop_distributions_tmp
  puts "DROP TABLE distributions_tmp;"
end

def update_classifications(table)
  puts UPDATE_CLASSIFICATIONS_ROOT_ID.gsub("table1", table)
  puts UPDATE_CLASSIFICATIONS_PARENT_ID.gsub("table1", table)
end

def import_attributes(csv)
  puts ".import #{csv} attributes"
end

def load_csv_to_attributes_table(csv)
  import_attributes(csv)
end

def load_csv_to_classifications_table(csv, table)
  create_classifications_tmp
  import_classifications_tmp(csv)
  create_classifications_idx(table)
  copy_classifications_tmp_to_idx(table)
  drop_classifications_tmp
  update_classifications(table)
end

def load_csv_to_distributions_table(csv, table)
  create_distributions_tmp
  import_distributions_tmp(csv)
  create_distributions_idx(table)
  copy_distributions_tmp_to_idx(table)
  drop_distributions_tmp
end

# main

set_csv_load_mode
load_csv_to_attributes_table("db/cache/attributes.csv")
load_csv_to_classifications_table("db/cache/gene_chromosome_ensembl.fix.csv", "table1")
load_csv_to_classifications_table("db/cache/gene_high_level_expression_refex.fix.csv", "table2")
load_csv_to_classifications_table("db/cache/gene_transcription_factors_chip_atlas.fix.csv", "table3")
load_csv_to_classifications_table("db/cache/protein_cellular_component_uniprot.fix.csv", "table4")
load_csv_to_classifications_table("db/cache/protein_disease_related_proteins_uniprot.fix.csv", "table5")
load_csv_to_distributions_table("db/cache/protein_molecular_mass_uniprot.csv", "table6")
