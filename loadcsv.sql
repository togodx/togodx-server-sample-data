.mode csv
.import db/cache/attributes.csv attributes
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
.import db/cache/gene_chromosome_ensembl.fix.csv classifications_tmp
CREATE TABLE IF NOT EXISTS "table1" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table1_on_classification" ON "table1" ("classification");
CREATE INDEX "index_table1_on_leaf" ON "table1" ("leaf");
CREATE INDEX "index_table1_on_parent_id" ON "table1" ("parent_id");
CREATE INDEX "index_table1_on_lft" ON "table1" ("lft");
CREATE INDEX "index_table1_on_rgt" ON "table1" ("rgt");
INSERT INTO table1 SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;
DROP TABLE classifications_tmp;
UPDATE table1 SET parent_id = NULL WHERE parent_id = "";
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
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
.import db/cache/gene_high_level_expression_refex.fix.csv classifications_tmp
CREATE TABLE IF NOT EXISTS "table2" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table2_on_classification" ON "table2" ("classification");
CREATE INDEX "index_table2_on_leaf" ON "table2" ("leaf");
CREATE INDEX "index_table2_on_parent_id" ON "table2" ("parent_id");
CREATE INDEX "index_table2_on_lft" ON "table2" ("lft");
CREATE INDEX "index_table2_on_rgt" ON "table2" ("rgt");
INSERT INTO table2 SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;
DROP TABLE classifications_tmp;
UPDATE table2 SET parent_id = NULL WHERE parent_id = "";
UPDATE table2
SET parent_id = (
  SELECT parent.id
  FROM table2 parent
  WHERE table2.classification_parent = parent.classification
)
WHERE EXISTS(
  SELECT 1
  FROM table2 parent
  WHERE table2.classification_parent = parent.classification
  AND table2.classification_parent IS NOT NULL
);
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
.import db/cache/gene_transcription_factors_chip_atlas.fix.csv classifications_tmp
CREATE TABLE IF NOT EXISTS "table3" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table3_on_classification" ON "table3" ("classification");
CREATE INDEX "index_table3_on_leaf" ON "table3" ("leaf");
CREATE INDEX "index_table3_on_parent_id" ON "table3" ("parent_id");
CREATE INDEX "index_table3_on_lft" ON "table3" ("lft");
CREATE INDEX "index_table3_on_rgt" ON "table3" ("rgt");
INSERT INTO table3 SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;
DROP TABLE classifications_tmp;
UPDATE table3 SET parent_id = NULL WHERE parent_id = "";
UPDATE table3
SET parent_id = (
  SELECT parent.id
  FROM table3 parent
  WHERE table3.classification_parent = parent.classification
)
WHERE EXISTS(
  SELECT 1
  FROM table3 parent
  WHERE table3.classification_parent = parent.classification
  AND table3.classification_parent IS NOT NULL
);
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
.import db/cache/protein_cellular_component_uniprot.fix.csv classifications_tmp
CREATE TABLE IF NOT EXISTS "table4" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table4_on_classification" ON "table4" ("classification");
CREATE INDEX "index_table4_on_leaf" ON "table4" ("leaf");
CREATE INDEX "index_table4_on_parent_id" ON "table4" ("parent_id");
CREATE INDEX "index_table4_on_lft" ON "table4" ("lft");
CREATE INDEX "index_table4_on_rgt" ON "table4" ("rgt");
INSERT INTO table4 SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;
DROP TABLE classifications_tmp;
UPDATE table4 SET parent_id = NULL WHERE parent_id = "";
UPDATE table4
SET parent_id = (
  SELECT parent.id
  FROM table4 parent
  WHERE table4.classification_parent = parent.classification
)
WHERE EXISTS(
  SELECT 1
  FROM table4 parent
  WHERE table4.classification_parent = parent.classification
  AND table4.classification_parent IS NOT NULL
);
CREATE TABLE IF NOT EXISTS "classifications_tmp" ("classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean);
.import db/cache/protein_disease_related_proteins_uniprot.fix.csv classifications_tmp
CREATE TABLE IF NOT EXISTS "table5" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "classification" varchar NOT NULL, "classification_label" varchar, "classification_parent" varchar, "leaf" boolean, "parent_id" integer, "lft" integer NOT NULL, "rgt" integer NOT NULL, "count" integer DEFAULT 0 NOT NULL);
CREATE INDEX "index_table5_on_classification" ON "table5" ("classification");
CREATE INDEX "index_table5_on_leaf" ON "table5" ("leaf");
CREATE INDEX "index_table5_on_parent_id" ON "table5" ("parent_id");
CREATE INDEX "index_table5_on_lft" ON "table5" ("lft");
CREATE INDEX "index_table5_on_rgt" ON "table5" ("rgt");
INSERT INTO table5 SELECT NULL,*,NULL,0,0,0 FROM classifications_tmp;
DROP TABLE classifications_tmp;
UPDATE table5 SET parent_id = NULL WHERE parent_id = "";
UPDATE table5
SET parent_id = (
  SELECT parent.id
  FROM table5 parent
  WHERE table5.classification_parent = parent.classification
)
WHERE EXISTS(
  SELECT 1
  FROM table5 parent
  WHERE table5.classification_parent = parent.classification
  AND table5.classification_parent IS NOT NULL
);
CREATE TABLE IF NOT EXISTS "distributions_tmp" ("distribution" varchar NOT NULL, "distribution_label" varchar, "distribution_value" float NOT NULL);
.import db/cache/protein_molecular_mass_uniprot.csv distributions_tmp
CREATE TABLE IF NOT EXISTS "table6" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "distribution" varchar NOT NULL, "distribution_label" varchar, "distribution_value" float NOT NULL);
CREATE INDEX "index_table6_on_distribution" ON "table6" ("distribution");
CREATE INDEX "index_table6_on_distribution_value" ON "table6" ("distribution_value");
INSERT INTO table6 SELECT NULL,* FROM distributions_tmp;
DROP TABLE distributions_tmp;
