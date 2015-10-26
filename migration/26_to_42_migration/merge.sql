-- db1: {nuxeo_default localhost 5432 csadmin cs1dn3b sslmode=disable}
-- db2: {mmi26_default localhost 5432 csadmin cs1dn3b sslmode=disable}
-- Run the following SQL againt db2:

/*
1. A "DROP TABLE" command means the table does not exist in the v4.2 deployment of MMI, but *may* need to be created in v4.2 DB schema
2. A "CREATE TABLE" command means the table does not exist in the v2.6 deployment of MMI and needs to be in the v4.2 DB schema
3. An ALTER command with "DROP COLUMN" on a table that exists in both v2.6 and v4.2 *may* actually indicate the column needs to be added to the v4.2 schema
*/


-- This is part of the v2.6 MMI AcquisitionsTenant42 document type
-- Exists in both v2.6 and v4.2, but columns are different.  We can rename v2.6 columns to match new -- v4.2 names.
--
ALTER TABLE acquisitions_mmi DROP COLUMN IF EXISTS mmiaccessiondate; -- => maps to "accessiondate" of v4.2 schema
ALTER TABLE acquisitions_mmi ADD COLUMN accessiondate timestamp without time zone;
ALTER TABLE acquisitions_mmi DROP COLUMN IF EXISTS acquisitionextent; -- => maps to "extent" of v4.2 schema
ALTER TABLE acquisitions_mmi ADD COLUMN extent character varying(1024);

-- Part of the v2.6 AcquisitionTenant42 document type.
DROP TABLE IF EXISTS acquisitions_mmi_mmiacquisitiondates;
ALTER TABLE acquisitions_mmi_mmiacquisitiondates DROP COLUMN IF EXISTS id;
ALTER TABLE acquisitions_mmi_mmiacquisitiondates DROP COLUMN IF EXISTS item;
ALTER TABLE acquisitions_mmi_mmiacquisitiondates DROP COLUMN IF EXISTS pos;

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE collectionspace_core ADD COLUMN refname character varying(1024);

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE relations_common ADD COLUMN relationshipmetatype character varying(1024);

-- Perhaps this v4.2 table matches the "affiliatedpersonorggroup" table in v2.6?
CREATE TABLE affiliatedentitygroup();
ALTER TABLE affiliatedentitygroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE affiliatedentitygroup ADD COLUMN affiliatedentity character varying(1024);
ALTER TABLE affiliatedentitygroup ADD COLUMN affiliatedentitytype character varying(1024);

-- This is part of the persons_mmi:affiliatedPersonOrgGroupList and PersonTenant42 doctype
-- We should probably map this to the v4.2 "affiliatedentitygroup" table
DROP TABLE IF EXISTS affiliatedpersonorggroup;
ALTER TABLE affiliatedpersonorggroup DROP COLUMN IF EXISTS affiliatedpersonorg;
ALTER TABLE affiliatedpersonorggroup DROP COLUMN IF EXISTS affiliatedpersonorgtype;
ALTER TABLE affiliatedpersonorggroup DROP COLUMN IF EXISTS id;

--- Unused
DROP TABLE IF EXISTS associatedtaxagroup;
--ALTER TABLE associatedtaxagroup DROP COLUMN IF EXISTS commonname;
--ALTER TABLE associatedtaxagroup DROP COLUMN IF EXISTS id;
--ALTER TABLE associatedtaxagroup DROP COLUMN IF EXISTS interaction;
--ALTER TABLE associatedtaxagroup DROP COLUMN IF EXISTS taxon;

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
ALTER TABLE collectionobjects_common ADD COLUMN computedcurrentlocation character varying(1024);

-- collectionobjects_mmi exists in both v2.6 and v4.2
-- Some v2.6 columns can be matched to new v4.2 columns
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS additionalresearchrequired; => maps to "additionalresearch" of v4.2 schema
ALTER TABLE collectionobjects_mmi ADD COLUMN additionalresearch boolean;
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS approvedbycurator; => maps to "curatorapproved" of v4.2 schema
ALTER TABLE collectionobjects_mmi ADD COLUMN curatorapproved boolean;
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS historicalnotesources; => maps to "historynotesources" of v4.2 schema
ALTER TABLE collectionobjects_mmi ADD COLUMN historynotesources character varying(1024);
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS initialcatalogingcompleted; => maps to "initialcataloging" of v4.2 schema
ALTER TABLE collectionobjects_mmi ADD COLUMN initialcataloging boolean;
ALTER TABLE collectionobjects_mmi ADD COLUMN objectproductionentitynote character varying(1024);
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS objecttitle;
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS worktype; * References the urn:cspace:movingimage.us:vocabularies:name(artifactclassworktype) vocabulary
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS artifactclass; * References the urn:cspace:movingimage.us:vocabularies:name(artifactclassworktype)
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS caption;
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS cataloguer; * Possibly unused by v2.6 MMI
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS comments; * Possibly unused by v2.6 MMI
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS dateofcataloging; * * Possibly unused by v2.6 MMI

-- Part of the v4.2 CollectionObjectTenant42 doctype. References the urn:cspace:movingimage.us:vocabularies:name(format) vocabulary
DROP TABLE IF EXISTS collectionobjects_mmi_formats;
ALTER TABLE collectionobjects_mmi_formats DROP COLUMN IF EXISTS id;
ALTER TABLE collectionobjects_mmi_formats DROP COLUMN IF EXISTS item;
ALTER TABLE collectionobjects_mmi_formats DROP COLUMN IF EXISTS pos;

-- Part of the v4.2 CollectionObjectTenant42 doctype. Seems to be just a multi-valued string field.
DROP TABLE IF EXISTS collectionobjects_mmi_mmiinscriptioncontents;
ALTER TABLE collectionobjects_mmi_mmiinscriptioncontents DROP COLUMN IF EXISTS id;
ALTER TABLE collectionobjects_mmi_mmiinscriptioncontents DROP COLUMN IF EXISTS item;
ALTER TABLE collectionobjects_mmi_mmiinscriptioncontents DROP COLUMN IF EXISTS pos;

-- Part of the v4.2 CollectionObjectTenant42 doctype. References the urn:cspace:movingimage.us:vocabularies:name(material) vocabulary
DROP TABLE IF EXISTS collectionobjects_mmi_mmimaterials;
ALTER TABLE collectionobjects_mmi_mmimaterials DROP COLUMN IF EXISTS id;
ALTER TABLE collectionobjects_mmi_mmimaterials DROP COLUMN IF EXISTS item;
ALTER TABLE collectionobjects_mmi_mmimaterials DROP COLUMN IF EXISTS pos;

-- Part of the v4.2 CollectionObjectTenant42 doctype. References the urn:cspace:movingimage.us:vocabularies:name(technique) vocabulary
DROP TABLE IF EXISTS collectionobjects_mmi_mmitechniques;
ALTER TABLE collectionobjects_mmi_mmitechniques DROP COLUMN IF EXISTS id;
ALTER TABLE collectionobjects_mmi_mmitechniques DROP COLUMN IF EXISTS item;
ALTER TABLE collectionobjects_mmi_mmitechniques DROP COLUMN IF EXISTS pos;

-- 'objprodentitygroup' this is part of collectionobjects_mmi:objProdEntityList of objProdEntityGroup
-- Part of the CollectionObjectTenant42 document type
-- **References urn:cspace:movingimage.us:personauthorities:name(person) authority
-- **References urn:cspace:movingimage.us:vocabularies:name(productionrole) vocabulary
DROP TABLE IF EXISTS objprodentitygroup;
ALTER TABLE objprodentitygroup DROP COLUMN IF EXISTS id;
ALTER TABLE objprodentitygroup DROP COLUMN IF EXISTS objprodentity;
ALTER TABLE objprodentitygroup DROP COLUMN IF EXISTS objprodentitynote;
ALTER TABLE objprodentitygroup DROP COLUMN IF EXISTS objprodentityrole;

-- 'contententitygroup' is part of collectionobjects_mmi:contentEntityList of contentEntityGroup
-- Part of the CollectionObjectTenant42 document type
-- **This v2.6 table maps to the v4.2 table "contententitiesgroup"
DROP TABLE IF EXISTS contententitygroup;
ALTER TABLE contententitygroup DROP COLUMN IF EXISTS contententity;
ALTER TABLE contententitygroup DROP COLUMN IF EXISTS contententitynote;
ALTER TABLE contententitygroup DROP COLUMN IF EXISTS contententitytype;
ALTER TABLE contententitygroup DROP COLUMN IF EXISTS id;

-- Exists in both v2.6 and v4.2, but unused in MMI v2.6
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

CREATE TABLE contententitiesgroup(); 
ALTER TABLE contententitiesgroup ADD COLUMN contententity character varying(1024);
ALTER TABLE contententitiesgroup ADD COLUMN contententitynote character varying(1024);
ALTER TABLE contententitiesgroup ADD COLUMN contententitytype character varying(1024);
ALTER TABLE contententitiesgroup ADD COLUMN id character varying(36) NOT NULL;

CREATE TABLE contentworksgroup();
ALTER TABLE contentworksgroup ADD COLUMN contentwork character varying(1024);
ALTER TABLE contentworksgroup ADD COLUMN contentworknote character varying(1024);
ALTER TABLE contentworksgroup ADD COLUMN contentworktype character varying(1024);
ALTER TABLE contentworksgroup ADD COLUMN id character varying(36) NOT NULL;

CREATE TABLE digitalworksgroup();
ALTER TABLE digitalworksgroup ADD COLUMN authoringenvironment character varying(1024);
ALTER TABLE digitalworksgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE digitalworksgroup ADD COLUMN programminglanguage character varying(1024);

CREATE TABLE envconditionnotegroup();
ALTER TABLE envconditionnotegroup ADD COLUMN envconditionnote character varying(1024);
ALTER TABLE envconditionnotegroup ADD COLUMN envconditionnotedate timestamp without time zone;
ALTER TABLE envconditionnotegroup ADD COLUMN id character varying(36) NOT NULL;

CREATE TABLE exhibitionpersongroup();
ALTER TABLE exhibitionpersongroup ADD COLUMN exhibitionperson character varying(1024);
ALTER TABLE exhibitionpersongroup ADD COLUMN exhibitionpersonrole character varying(1024);
ALTER TABLE exhibitionpersongroup ADD COLUMN id character varying(36) NOT NULL;

CREATE TABLE exhibitionreferencegroup();
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreference character varying(1024);
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreferencenote character varying(1024);
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreferencetype character varying(1024);
ALTER TABLE exhibitionreferencegroup ADD COLUMN id character varying(36) NOT NULL;

CREATE TABLE exhibitions_common();
ALTER TABLE exhibitions_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_organizers ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_organizers ADD COLUMN pos integer;

CREATE TABLE exhibitions_common_organizers();
ALTER TABLE exhibitions_common_organizers ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_organizers ADD COLUMN item character varying(1024);
ALTER TABLE exhibitions_common_organizers ADD COLUMN pos integer;

CREATE TABLE exhibitions_common_sponsors();
ALTER TABLE exhibitions_common_sponsors ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_sponsors ADD COLUMN item character varying(1024);
ALTER TABLE exhibitions_common_sponsors ADD COLUMN pos integer;

-- *** Unused
DROP TABLE IF EXISTS fieldcolldepthgroup;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS id;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS maxdepth;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS mindepth;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS notes;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS qualifier;
ALTER TABLE fieldcolldepthgroup DROP COLUMN IF EXISTS units;

-- *** Unused
DROP TABLE IF EXISTS fieldcollelevationgroup;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS id;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS maxelevation;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS minelevation;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS notes;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS qualifier;
ALTER TABLE fieldcollelevationgroup DROP COLUMN IF EXISTS units;

CREATE TABLE filmvideocomponentsgroup();
ALTER TABLE filmvideocomponentsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE filmvideocomponentsgroup ADD COLUMN originalaudioformat character varying(1024);
ALTER TABLE filmvideocomponentsgroup ADD COLUMN originalformat character varying(1024);

ALTER TABLE fulltext ADD COLUMN binarytext_description text;
ALTER TABLE fulltext ADD COLUMN binarytext_title text;
ALTER TABLE fulltext ADD COLUMN fulltext_description text;
ALTER TABLE fulltext ADD COLUMN fulltext_title text;
ALTER TABLE fulltext ADD COLUMN simpletext_description text;
ALTER TABLE fulltext ADD COLUMN simpletext_title text;

CREATE TABLE hazardgroup();
ALTER TABLE hazardgroup ADD COLUMN hazard character varying(1024);
ALTER TABLE hazardgroup ADD COLUMN hazarddate timestamp without time zone;
ALTER TABLE hazardgroup ADD COLUMN hazardnote character varying(1024);
ALTER TABLE hazardgroup ADD COLUMN id character varying(36) NOT NULL;

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE iptc ALTER COLUMN caption TYPE text;

CREATE TABLE legalreqsheldgroup();
ALTER TABLE legalreqsheldgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheld character varying(1024);
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldbegindate timestamp without time zone;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldenddate timestamp without time zone;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldnumber character varying(1024);
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldrenewdate timestamp without time zone;

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE media_mmi DROP COLUMN IF EXISTS mediastatus; => maps to "status" field
ALTER TABLE media_mmi ADD COLUMN status character varying(1024);

-- *** Unused
DROP TABLE IF EXISTS nh_titlegroup;
ALTER TABLE nh_titlegroup DROP COLUMN IF EXISTS id;
ALTER TABLE nh_titlegroup DROP COLUMN IF EXISTS item;
ALTER TABLE nh_titlegroup DROP COLUMN IF EXISTS pos;

-- *** Unused
DROP TABLE IF EXISTS notes_common;
ALTER TABLE notes_common DROP COLUMN IF EXISTS author;
ALTER TABLE notes_common DROP COLUMN IF EXISTS content;
ALTER TABLE notes_common DROP COLUMN IF EXISTS date;
ALTER TABLE notes_common DROP COLUMN IF EXISTS id;

ALTER TABLE nxp_uidseq ADD COLUMN seq_id integer NOT NULL;
ALTER TABLE nxp_uidseq ADD COLUMN seq_index integer NOT NULL;
ALTER TABLE nxp_uidseq ADD COLUMN seq_key character varying(255) NOT NULL;

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE persons_common DROP COLUMN IF EXISTS description;

-- Exists in both v2.6 and v4.2
-- Part of the PersonTenant42 documenttype
ALTER TABLE persons_mmi DROP COLUMN IF EXISTS lifespan;

-- This is part of the Person document type (table contents identical to v2.6 persons_mmi_orgfunctions)
DROP TABLE IF EXISTS persons_mmi_orgcontactnames;
ALTER TABLE persons_mmi_orgcontactnames DROP COLUMN IF EXISTS id;
ALTER TABLE persons_mmi_orgcontactnames DROP COLUMN IF EXISTS item;
ALTER TABLE persons_mmi_orgcontactnames DROP COLUMN IF EXISTS pos;

-- This is part of the Person document type (table contents identical to v2.6 persons_mmi_orgcontactnames)
DROP TABLE IF EXISTS persons_mmi_orgfunctions;
ALTER TABLE persons_mmi_orgfunctions DROP COLUMN IF EXISTS id;
ALTER TABLE persons_mmi_orgfunctions DROP COLUMN IF EXISTS item;
ALTER TABLE persons_mmi_orgfunctions DROP COLUMN IF EXISTS pos;

-- Not used my MMI needed
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS lifespan;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS namesource;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS scopenote;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS sourcenote;
ALTER TABLE persons_naturalhistory_namefunctions DROP COLUMN IF EXISTS id;
ALTER TABLE persons_naturalhistory_namefunctions DROP COLUMN IF EXISTS item;
ALTER TABLE persons_naturalhistory_namefunctions DROP COLUMN IF EXISTS pos;
ALTER TABLE persons_naturalhistory_nametypes DROP COLUMN IF EXISTS id;
ALTER TABLE persons_naturalhistory_nametypes DROP COLUMN IF EXISTS item;
ALTER TABLE persons_naturalhistory_nametypes DROP COLUMN IF EXISTS pos;
ALTER TABLE persons_naturalhistory_orgcontactnames DROP COLUMN IF EXISTS id;
ALTER TABLE persons_naturalhistory_orgcontactnames DROP COLUMN IF EXISTS item;
ALTER TABLE persons_naturalhistory_orgcontactnames DROP COLUMN IF EXISTS pos;

-- Exists in both v2.6 and v4.2 DB schemas
ALTER TABLE picture ALTER COLUMN caption TYPE text;

CREATE TABLE publicitems_common();
ALTER TABLE publicitems_common ADD COLUMN contentaccesscountlimit bigint;
ALTER TABLE publicitems_common ADD COLUMN contentaccessedcount bigint;
ALTER TABLE publicitems_common ADD COLUMN contentcreationjobid character varying(1024);
ALTER TABLE publicitems_common ADD COLUMN contentexpirationdate timestamp without time zone;
ALTER TABLE publicitems_common ADD COLUMN contentid character varying(1024);
ALTER TABLE publicitems_common ADD COLUMN contentname character varying(1024);
ALTER TABLE publicitems_common ADD COLUMN contentsource character varying(1024);
ALTER TABLE publicitems_common ADD COLUMN contenturi character varying(1024);
ALTER TABLE publicitems_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE publicitems_common ADD COLUMN itemnumber character varying(1024);

CREATE TABLE registration();
ALTER TABLE registration ADD COLUMN accepted boolean;
ALTER TABLE registration ADD COLUMN comment character varying(1024);
ALTER TABLE registration ADD COLUMN copyto character varying(1024);
ALTER TABLE registration ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE registration ADD COLUMN validationmethod character varying(1024);

CREATE TABLE registrationconfiguration();
ALTER TABLE registrationconfiguration ADD COLUMN allowdirectvalidationforexistinguser boolean;
ALTER TABLE registrationconfiguration ADD COLUMN allowusercreation boolean;
ALTER TABLE registrationconfiguration ADD COLUMN displaylocalregistrationtab boolean;
ALTER TABLE registrationconfiguration ADD COLUMN forcerightassignment boolean;
ALTER TABLE registrationconfiguration ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE registrationconfiguration ADD COLUMN name character varying(1024);

CREATE TABLE relatedconceptsgroup();
ALTER TABLE relatedconceptsgroup ADD COLUMN conceptrelationtype character varying(1024);
ALTER TABLE relatedconceptsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE relatedconceptsgroup ADD COLUMN relatedconcept character varying(1024);

-- Exists in both v2.6 and v4.2 schemas
ALTER TABLE relatedtextresource ALTER COLUMN relatedtext TYPE text;

CREATE TABLE salvageprioritycodegroup();
ALTER TABLE salvageprioritycodegroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE salvageprioritycodegroup ADD COLUMN salvageprioritycode character varying(1024);
ALTER TABLE salvageprioritycodegroup ADD COLUMN salvageprioritycodedate timestamp without time zone;

CREATE TABLE status();
ALTER TABLE status ADD COLUMN administrative_status character varying(1024);
ALTER TABLE status ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE status ADD COLUMN instanceid character varying(1024);
ALTER TABLE status ADD COLUMN serviceid character varying(1024);
ALTER TABLE status ADD COLUMN statusmessage character varying(1024);
ALTER TABLE status ADD COLUMN userlogin character varying(1024);

CREATE TABLE techassessmentgroup();
ALTER TABLE techassessmentgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE techassessmentgroup ADD COLUMN techassessment character varying(1024);
ALTER TABLE techassessmentgroup ADD COLUMN techassessmentdate timestamp without time zone;

CREATE TABLE technicalchangesgroup();
ALTER TABLE technicalchangesgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE technicalchangesgroup ADD COLUMN newsupport character varying(1024);
ALTER TABLE technicalchangesgroup ADD COLUMN previoussupport character varying(1024);
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchange character varying(1024);
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchangenote character varying(1024);
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchangereason character varying(1024);

-- Unused and can be dropped
DROP TABLE IF EXISTS typespecimengroup;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS id;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS institution;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS institutiontype;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS kindoftype;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS notes;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS reference;
ALTER TABLE typespecimengroup DROP COLUMN IF EXISTS refpage;

CREATE TABLE userinfo();
ALTER TABLE userinfo ADD COLUMN company character varying(1024);
ALTER TABLE userinfo ADD COLUMN email character varying(1024);
ALTER TABLE userinfo ADD COLUMN firstname character varying(1024);
ALTER TABLE userinfo ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE userinfo ADD COLUMN lastname character varying(1024);
ALTER TABLE userinfo ADD COLUMN login character varying(1024);
ALTER TABLE userinfo ADD COLUMN password character varying(1024);

CREATE TABLE userinfo_groups();
ALTER TABLE userinfo_groups ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE userinfo_groups ADD COLUMN item character varying(1024);
ALTER TABLE userinfo_groups ADD COLUMN pos integer;

CREATE TABLE valuationcontrols_common();
ALTER TABLE valuationcontrols_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE valuationcontrols_common ADD COLUMN valuationcontrolrefnumber character varying(1024);
ALTER TABLE valuationcontrols_common ADD COLUMN valuedate timestamp without time zone;
ALTER TABLE valuationcontrols_common ADD COLUMN valuenote character varying(1024);
ALTER TABLE valuationcontrols_common ADD COLUMN valuerenewaldate timestamp without time zone;
ALTER TABLE valuationcontrols_common ADD COLUMN valuesource character varying(1024);
ALTER TABLE valuationcontrols_common ADD COLUMN valuetype character varying(1024);

CREATE TABLE valueamounts();
ALTER TABLE valueamounts ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE valueamounts ADD COLUMN valueamount double precision;
ALTER TABLE valueamounts ADD COLUMN valuecurrency character varying(1024);

CREATE TABLE venuegroup();
ALTER TABLE venuegroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE venuegroup ADD COLUMN venue character varying(1024);
ALTER TABLE venuegroup ADD COLUMN venueattendance character varying(1024);
ALTER TABLE venuegroup ADD COLUMN venueclosingdate timestamp without time zone;
ALTER TABLE venuegroup ADD COLUMN venueopeningdate timestamp without time zone;
ALTER TABLE venuegroup ADD COLUMN venueurl character varying(1024);

CREATE TABLE visualpreferencesgroup();
ALTER TABLE visualpreferencesgroup ADD COLUMN colorpalette character varying(1024);
ALTER TABLE visualpreferencesgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE visualpreferencesgroup ADD COLUMN screenresolution character varying(1024);

CREATE TABLE workinggroup();
ALTER TABLE workinggroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE workinggroup ADD COLUMN workinggroupnote character varying(1024);
ALTER TABLE workinggroup ADD COLUMN workinggrouptitle character varying(1024);

-- 'works_common' exists in both v2.6 and v4.2 schemas
-- **Ideally, this schema/table would not be modified by a deployer.  Move data to new v4.2 "works_mmi" schema
-- **References the urn:cspace:movingimage.us:workauthorities:name(work) authority
ALTER TABLE works_common DROP COLUMN IF EXISTS genre; -- *Doesn't appear to be used in v2.6 MMI data
ALTER TABLE works_common DROP COLUMN IF EXISTS medium; -- *References the urn:cspace:movingimage.us:vocabularies:name(workmedium) vocabulary
ALTER TABLE works_common DROP COLUMN IF EXISTS scopenote; -- *Doesn't appear to be used in v2.6 MMI data
ALTER TABLE works_common ADD COLUMN workhistorynote character varying(1024);
ALTER TABLE works_common ADD COLUMN worktype character varying(1024);

-- Need to migrate v2.6 data from "works_common" to this table.
CREATE TABLE works_mmi();
ALTER TABLE works_mmi ADD COLUMN genre character varying(1024);
ALTER TABLE works_mmi ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE works_mmi ADD COLUMN medium character varying(1024);

-- Exists in both v2.6 and v4.2 database schemas
ALTER TABLE worktermgroup ADD COLUMN termformatteddisplayname character varying(1024);
