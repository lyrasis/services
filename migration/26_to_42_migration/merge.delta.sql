-- This is part of the v2.6 MMI AcquisitionsTenant42 document type
-- Exists in both v2.6 and v4.2, but columns are different.  We can rename v2.6 columns to match new -- v4.2 names.
--
--ALTER TABLE acquisitions_mmi DROP COLUMN IF EXISTS mmiaccessiondate; -- => maps to "accessiondate" of v4.2 schema
--ALTER TABLE acquisitions_mmi ADD COLUMN accessiondate timestamp without time zone;
ALTER TABLE acquisitions_mmi RENAME COLUMN mmiaccessiondate TO accessiondate;

--ALTER TABLE acquisitions_mmi DROP COLUMN IF EXISTS acquisitionextent; -- => maps to "extent" of v4.2 schema
--ALTER TABLE acquisitions_mmi ADD COLUMN extent character varying(1024);
ALTER TABLE acquisitions_mmi RENAME COLUMN acquisitionextent TO extent;

-- Exists in both v2.6 and v4.2 schemas
-- Will this be required in v4.2?
ALTER TABLE collectionspace_core ADD COLUMN refname character varying(1024);

-- Exists in both v2.6 and v4.2 schemas
-- Will this be required in v4.2?
ALTER TABLE relations_common ADD COLUMN relationshipmetatype character varying(1024);

-- This is part of the persons_mmi:affiliatedPersonOrgGroupList and PersonTenant42 doctype
-- We should probably map this to the v4.2 "affiliatedentitygroup" table
ALTER TABLE affiliatedpersonorggroup RENAME COLUMN IF EXISTS affiliatedentity;
ALTER TABLE affiliatedpersonorggroup DROP COLUMN IF EXISTS affiliatedentitytype;
ALTER TABLE affiliatedpersonorggroup RENAME TO affiliatedentitygroup;

CREATE TABLE citationagentinfogroup();
ALTER TABLE citationagentinfogroup ADD COLUMN agent character varying(1024);
ALTER TABLE citationagentinfogroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationagentinfogroup ADD COLUMN note character varying(1024);
ALTER TABLE citationagentinfogroup ADD COLUMN role character varying(1024);


CREATE TABLE citationauthorities_common();
ALTER TABLE citationauthorities_common ADD COLUMN description character varying(1024);
ALTER TABLE citationauthorities_common ADD COLUMN displayname character varying(1024);
ALTER TABLE citationauthorities_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationauthorities_common ADD COLUMN refname character varying(1024);
ALTER TABLE citationauthorities_common ADD COLUMN shortidentifier character varying(1024);
ALTER TABLE citationauthorities_common ADD COLUMN source character varying(1024);
ALTER TABLE citationauthorities_common ADD COLUMN vocabtype character varying(1024);


CREATE TABLE citationpublicationinfogroup();
ALTER TABLE citationpublicationinfogroup ADD COLUMN edition character varying(1024);
ALTER TABLE citationpublicationinfogroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationpublicationinfogroup ADD COLUMN pages character varying(1024);
ALTER TABLE citationpublicationinfogroup ADD COLUMN publicationplace character varying(1024);
ALTER TABLE citationpublicationinfogroup ADD COLUMN publisher character varying(1024);


CREATE TABLE citationrelatedtermsgroup();
ALTER TABLE citationrelatedtermsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationrelatedtermsgroup ADD COLUMN relatedterm character varying(1024);
ALTER TABLE citationrelatedtermsgroup ADD COLUMN relationtype character varying(1024);


CREATE TABLE citationresourceidentgroup();
ALTER TABLE citationresourceidentgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationresourceidentgroup ADD COLUMN resourceident character varying(1024);
ALTER TABLE citationresourceidentgroup ADD COLUMN type character varying(1024);


CREATE TABLE citations_common();
ALTER TABLE citations_common ADD COLUMN citationnote character varying(1024);
ALTER TABLE citations_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citations_common ADD COLUMN inauthority character varying(1024);
ALTER TABLE citations_common ADD COLUMN refname character varying(1024);
ALTER TABLE citations_common ADD COLUMN shortidentifier character varying(1024);


CREATE TABLE citationtermgroup();
ALTER TABLE citationtermgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationtermgroup ADD COLUMN termdisplayname character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termformatteddisplayname character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termfullcitation character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termissue character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termlanguage character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termname character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termprefforlang boolean;
ALTER TABLE citationtermgroup ADD COLUMN termqualifier character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsectiontitle character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsource character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsourcedetail character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsourceid character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsourcenote character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termstatus character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termsubtitle character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termtitle character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termtype character varying(1024);
ALTER TABLE citationtermgroup ADD COLUMN termvolume character varying(1024);


CREATE TABLE collectionobjects_fineart();
ALTER TABLE collectionobjects_fineart ADD COLUMN cataloglevel character varying(1024);
ALTER TABLE collectionobjects_fineart ADD COLUMN creatordescription character varying(1024);
ALTER TABLE collectionobjects_fineart ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_fineart ADD COLUMN materialtechniquedescription character varying(1024);

-- Exists in both v2.6 and v4.2
-- Not used in MMI?
ALTER TABLE collectionobjects_common ADD COLUMN computedcurrentlocation character varying(1024);

-- collectionobjects_mmi exists in both v2.6 and v4.2
-- Some v2.6 columns can be matched to new v4.2 columns
-- ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS additionalresearchrequired; => maps to "additionalresearch" of v4.2 schema
-- ALTER TABLE collectionobjects_mmi ADD COLUMN additionalresearch boolean;
ALTER TABLE collectionobjects_mmi RENAME COLUMN additionalresearchrequired TO additionalresearch;

-- ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS approvedbycurator; => maps to "curatorapproved" of v4.2 schema
-- ALTER TABLE collectionobjects_mmi ADD COLUMN curatorapproved boolean;
ALTER TABLE collectionobjects_mmi RENAME COLUMN approvedbycurator to curatorapproved;

-- ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS historicalnotesources; => maps to "historynotesources" of v4.2 schema
-- ALTER TABLE collectionobjects_mmi ADD COLUMN historynotesources character varying(1024);
ALTER TABLE collectionobjects_mmi RENAME COLUMN historicalnotesources TO historynotesources;

-- ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS initialcatalogingcompleted; => maps to "initialcataloging" of v4.2 schema
-- ALTER TABLE collectionobjects_mmi ADD COLUMN initialcataloging boolean;
ALTER TABLE collectionobjects_mmi RENAME COLUMN initialcatalogingcompleted TO initialcataloging;
ALTER TABLE collectionobjects_mmi ADD COLUMN objectproductionentitynote character varying(1024); -- used as objProdEntityNote in local-collectionobject of MMI v2.6

/* Can be dropped because they are unused in v2.6 MMI */
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS cataloguer; --* Unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where cataloguer is not null;'
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS comments; --* Unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where comments is not null;'
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS dateofcataloging; --* Possibly unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where dateofcataloging is not null;'

/* Contains data from MMI v2.6 DB, but table has been renamed in MMI v4.2 config */
ALTER TABLE contententitygroup RENAME TO contententitiesgroup;

-- Exists in both v2.6 and v4.2, but unused in MMI v2.6
-- Updated since v2.6 to fewer columns.
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldcollectiondateearliest;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldcollectiondatelatest;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldloccoordinatesystem;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldloccountry;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldloccounty;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldlocelevation;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldlocgeodeticdatum;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldlochighergeography;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldloclatdecimal;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldloclongdecimal;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS fieldlocstate;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS labelfooter;
ALTER TABLE collectionobjects_naturalhistory DROP COLUMN IF EXISTS labelheader;


-- New schema for Variable Media extension
CREATE TABLE collectionobjects_variablemedia();
ALTER TABLE collectionobjects_variablemedia ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia ADD COLUMN nonstandardcode character varying(1024);
ALTER TABLE collectionobjects_variablemedia ADD COLUMN sourceexternaldata character varying(1024);
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN item character varying(1024);
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN pos integer;
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN item character varying(1024);
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN pos integer;
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN item character varying(1024);
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN pos integer;
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN item character varying(1024);
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN pos integer;
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN item character varying(1024);
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN pos integer;


CREATE TABLE completenessgroup();
ALTER TABLE completenessgroup ADD COLUMN completeness character varying(1024);
ALTER TABLE completenessgroup ADD COLUMN completenessdate timestamp without time zone;
ALTER TABLE completenessgroup ADD COLUMN completenessnote character varying(1024);
ALTER TABLE completenessgroup ADD COLUMN id character varying(36) NOT NULL;


CREATE TABLE concepts_fineart();
ALTER TABLE concepts_fineart ADD COLUMN conceptrecordtype character varying(1024);
ALTER TABLE concepts_fineart ADD COLUMN conceptremarks character varying(1024);
ALTER TABLE concepts_fineart ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE concepts_fineart ADD COLUMN othernameflags character varying(1024);


-- Exists in both v2.6 and v4.2 schemas
-- Needed in v4.2 code?
ALTER TABLE concepttermgroup ADD COLUMN termformatteddisplayname character varying(1024);


CREATE TABLE conditioncheckgroup();
ALTER TABLE conditioncheckgroup ADD COLUMN condition character varying(1024);
ALTER TABLE conditioncheckgroup ADD COLUMN conditiondate timestamp without time zone;
ALTER TABLE conditioncheckgroup ADD COLUMN conditionnote character varying(1024);
ALTER TABLE conditioncheckgroup ADD COLUMN id character varying(36) NOT NULL;


CREATE TABLE conditionchecks_common();
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckassessmentdate timestamp without time zone;
ALTER TABLE conditionchecks_common ADD COLUMN conditionchecker character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckmethod character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN conditionchecknote character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckreason character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckrefnumber character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN conservationtreatmentpriority character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN displayrecommendations character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN envrecommendations character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN handlingrecommendations character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE conditionchecks_common ADD COLUMN legalrequirements character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN nextconditioncheckdate timestamp without time zone;
ALTER TABLE conditionchecks_common ADD COLUMN objectauditcategory character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN packingrecommendations character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN securityrecommendations character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN specialrequirements character varying(1024);
ALTER TABLE conditionchecks_common ADD COLUMN storagerequirements character varying(1024);
