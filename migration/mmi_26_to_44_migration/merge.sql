-- Nuxeo specific tables and columns
--
ALTER TABLE fulltext ADD COLUMN binarytext_description text;
ALTER TABLE fulltext ADD COLUMN binarytext_title text;
ALTER TABLE fulltext ADD COLUMN fulltext_description text;
ALTER TABLE fulltext ADD COLUMN fulltext_title text;
ALTER TABLE fulltext ADD COLUMN simpletext_description text;
ALTER TABLE fulltext ADD COLUMN simpletext_title text;

-- Update the MMI repository domain root name
UPDATE hierarchy SET name='mmi' WHERE name='mmi-domain';

-- WARNING: This type change may not work well: (character varying to text).
ALTER TABLE iptc ALTER COLUMN caption TYPE text;


-- Not used in MMI v2.6 and not part of the v4.x schema
DROP TABLE IF EXISTS associatedtaxagroup;

-- Exists in both v2.6 and v4.2 schemas
-- Will this be required in v4.2?
ALTER TABLE collectionspace_core ADD COLUMN refname character varying;

-- WARNING: This type change may not work well: (character varying to text).
ALTER TABLE relatedtextresource ALTER COLUMN relatedtext TYPE text;

-- Exists in both v2.6 and v4.2 schemas
-- Will this be required in v4.2?
ALTER TABLE relations_common ADD COLUMN relationshipmetatype character varying;

-- Because of a conflict with the Variable Media profile schema extension "contentWorksGroupList/contentWorksGroup",
-- we're going to rename this table (an original MMI v2.6 table) to keep its data intact.
ALTER TABLE contentworkgroup RENAME TO mmicontentworkgroup;

-- Should we create this table?  It's part of the standard v4.x schema, but not used by MMI
CREATE TABLE contentworksgroup();
ALTER TABLE contentworksgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE contentworksgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE contentworksgroup TO reader_mmi;
ALTER TABLE contentworksgroup ADD COLUMN contentwork character varying;
ALTER TABLE contentworksgroup ADD COLUMN contentworknote character varying;
ALTER TABLE contentworksgroup ADD COLUMN contentworktype character varying;
ALTER TABLE contentworksgroup ADD COLUMN id character varying(36) NOT NULL;


CREATE TABLE citationagentinfogroup();
ALTER TABLE citationagentinfogroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationagentinfogroup TO nuxeo_mmi;
GRANT SELECT ON TABLE citationagentinfogroup TO reader_mmi;
ALTER TABLE citationagentinfogroup ADD COLUMN agent character varying;
ALTER TABLE citationagentinfogroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationagentinfogroup ADD COLUMN note character varying;
ALTER TABLE citationagentinfogroup ADD COLUMN role character varying;

CREATE TABLE citationauthorities_common();
ALTER TABLE citationauthorities_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationauthorities_common TO nuxeo_mmi;
GRANT SELECT ON TABLE citationauthorities_common TO reader_mmi;
ALTER TABLE citationauthorities_common ADD COLUMN description character varying;
ALTER TABLE citationauthorities_common ADD COLUMN displayname character varying;
ALTER TABLE citationauthorities_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationauthorities_common ADD COLUMN refname character varying;
ALTER TABLE citationauthorities_common ADD COLUMN shortidentifier character varying;
ALTER TABLE citationauthorities_common ADD COLUMN source character varying;
ALTER TABLE citationauthorities_common ADD COLUMN vocabtype character varying;

CREATE TABLE citationpublicationinfogroup();
ALTER TABLE citationpublicationinfogroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationpublicationinfogroup TO nuxeo_mmi;
GRANT SELECT ON TABLE citationpublicationinfogroup TO reader_mmi;
ALTER TABLE citationpublicationinfogroup ADD COLUMN edition character varying;
ALTER TABLE citationpublicationinfogroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationpublicationinfogroup ADD COLUMN pages character varying;
ALTER TABLE citationpublicationinfogroup ADD COLUMN publicationplace character varying;
ALTER TABLE citationpublicationinfogroup ADD COLUMN publisher character varying;

CREATE TABLE citationrelatedtermsgroup();
ALTER TABLE citationrelatedtermsgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationrelatedtermsgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE citationrelatedtermsgroup TO reader_mmi;
ALTER TABLE citationrelatedtermsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationrelatedtermsgroup ADD COLUMN relatedterm character varying;
ALTER TABLE citationrelatedtermsgroup ADD COLUMN relationtype character varying;

CREATE TABLE citationresourceidentgroup();
ALTER TABLE citationresourceidentgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationresourceidentgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE citationresourceidentgroup TO reader_mmi;
ALTER TABLE citationresourceidentgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationresourceidentgroup ADD COLUMN resourceident character varying;
ALTER TABLE citationresourceidentgroup ADD COLUMN type character varying;

CREATE TABLE citations_common();
ALTER TABLE citations_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citations_common TO nuxeo_mmi;
GRANT SELECT ON TABLE citations_common TO reader_mmi;
ALTER TABLE citations_common ADD COLUMN citationnote character varying;
ALTER TABLE citations_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citations_common ADD COLUMN inauthority character varying;
ALTER TABLE citations_common ADD COLUMN refname character varying;
ALTER TABLE citations_common ADD COLUMN shortidentifier character varying;

CREATE TABLE citationtermgroup();
ALTER TABLE citationtermgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE citationtermgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE citationtermgroup TO reader_mmi;
ALTER TABLE citationtermgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE citationtermgroup ADD COLUMN termdisplayname character varying;
ALTER TABLE citationtermgroup ADD COLUMN termformatteddisplayname character varying;
ALTER TABLE citationtermgroup ADD COLUMN termfullcitation character varying;
ALTER TABLE citationtermgroup ADD COLUMN termissue character varying;
ALTER TABLE citationtermgroup ADD COLUMN termlanguage character varying;
ALTER TABLE citationtermgroup ADD COLUMN termname character varying;
ALTER TABLE citationtermgroup ADD COLUMN termprefforlang boolean;
ALTER TABLE citationtermgroup ADD COLUMN termqualifier character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsectiontitle character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsource character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsourcedetail character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsourceid character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsourcenote character varying;
ALTER TABLE citationtermgroup ADD COLUMN termstatus character varying;
ALTER TABLE citationtermgroup ADD COLUMN termsubtitle character varying;
ALTER TABLE citationtermgroup ADD COLUMN termtitle character varying;
ALTER TABLE citationtermgroup ADD COLUMN termtype character varying;
ALTER TABLE citationtermgroup ADD COLUMN termvolume character varying;

-- The “collectionobjects_common” table exists in both v2.6 and v4.2
-- Not used in MMI? What happens to this field after migration? Will this get updated?
ALTER TABLE collectionobjects_common ADD COLUMN computedcurrentlocation character varying;

CREATE TABLE collectionobjects_fineart();
ALTER TABLE collectionobjects_fineart OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_fineart TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_fineart TO reader_mmi;
ALTER TABLE collectionobjects_fineart ADD COLUMN cataloglevel character varying;
ALTER TABLE collectionobjects_fineart ADD COLUMN creatordescription character varying;
ALTER TABLE collectionobjects_fineart ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_fineart ADD COLUMN materialtechniquedescription character varying;


/* Can be dropped because they are unused in v2.6 MMI */
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS cataloguer; --* Unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where cataloguer is not null;'
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS comments; --* Unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where comments is not null;'
ALTER TABLE collectionobjects_mmi DROP COLUMN IF EXISTS dateofcataloging; --* Possibly unused by v2.6 MMI and missing from MMI v2.6 config -confirmed with 'select count(*) from collectionobjects_mmi where dateofcataloging is not null;'

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

-- Exists in both v2.6 and v4.2, but unused in MMI v2.6
-- Updated since v2.6 to fewer columns.
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS lifespan;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS namesource;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS scopenote;
ALTER TABLE persons_naturalhistory DROP COLUMN IF EXISTS sourcenote;

-- These tables are unused my MMI v2.6 and no longer exist in v4.x
DROP TABLE IF EXISTS persons_naturalhistory_namefunctions;
DROP TABLE IF EXISTS persons_naturalhistory_nametypes;
DROP TABLE IF EXISTS persons_naturalhistory_orgcontactnames;

-- New schema for Variable Media extension
CREATE TABLE collectionobjects_variablemedia();
ALTER TABLE collectionobjects_variablemedia OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia ADD COLUMN nonstandardcode character varying;
ALTER TABLE collectionobjects_variablemedia ADD COLUMN sourceexternaldata character varying;

CREATE TABLE collectionobjects_variablemedia_compressionsystems();
ALTER TABLE collectionobjects_variablemedia_compressionsystems OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia_compressionsystems TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia_compressionsystems TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN item character varying;
ALTER TABLE collectionobjects_variablemedia_compressionsystems ADD COLUMN pos integer;

CREATE TABLE collectionobjects_variablemedia_copiesprovided();
ALTER TABLE collectionobjects_variablemedia_copiesprovided OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia_copiesprovided TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia_copiesprovided TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN item character varying;
ALTER TABLE collectionobjects_variablemedia_copiesprovided ADD COLUMN pos integer;

CREATE TABLE collectionobjects_variablemedia_creationhardwares();
ALTER TABLE collectionobjects_variablemedia_creationhardwares OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia_creationhardwares TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia_creationhardwares TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN item character varying;
ALTER TABLE collectionobjects_variablemedia_creationhardwares ADD COLUMN pos integer;

CREATE TABLE collectionobjects_variablemedia_playbackhardwares();
ALTER TABLE collectionobjects_variablemedia_playbackhardwares OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia_playbackhardwares TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia_playbackhardwares TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN item character varying;
ALTER TABLE collectionobjects_variablemedia_playbackhardwares ADD COLUMN pos integer;

CREATE TABLE collectionobjects_variablemedia_ratioformats();
ALTER TABLE collectionobjects_variablemedia_ratioformats OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE collectionobjects_variablemedia_ratioformats TO nuxeo_mmi;
GRANT SELECT ON TABLE collectionobjects_variablemedia_ratioformats TO reader_mmi;
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN item character varying;
ALTER TABLE collectionobjects_variablemedia_ratioformats ADD COLUMN pos integer;

CREATE TABLE completenessgroup();
ALTER TABLE completenessgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE completenessgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE completenessgroup TO reader_mmi;
ALTER TABLE completenessgroup ADD COLUMN completeness character varying;
ALTER TABLE completenessgroup ADD COLUMN completenessdate timestamp without time zone;
ALTER TABLE completenessgroup ADD COLUMN completenessnote character varying;
ALTER TABLE completenessgroup ADD COLUMN id character varying(36) NOT NULL;


CREATE TABLE concepts_fineart();
ALTER TABLE concepts_fineart OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE concepts_fineart TO nuxeo_mmi;
GRANT SELECT ON TABLE concepts_fineart TO reader_mmi;
ALTER TABLE concepts_fineart ADD COLUMN conceptrecordtype character varying;
ALTER TABLE concepts_fineart ADD COLUMN conceptremarks character varying;
ALTER TABLE concepts_fineart ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE concepts_fineart ADD COLUMN othernameflags character varying;


-- Exists in both v2.6 and v4.2 schemas
-- Needed in v4.2 code?
ALTER TABLE concepttermgroup ADD COLUMN termformatteddisplayname character varying;


CREATE TABLE conditioncheckgroup();
ALTER TABLE conditioncheckgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE conditioncheckgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE conditioncheckgroup TO reader_mmi;
ALTER TABLE conditioncheckgroup ADD COLUMN condition character varying;
ALTER TABLE conditioncheckgroup ADD COLUMN conditiondate timestamp without time zone;
ALTER TABLE conditioncheckgroup ADD COLUMN conditionnote character varying;
ALTER TABLE conditioncheckgroup ADD COLUMN id character varying(36) NOT NULL;


CREATE TABLE conditionchecks_common();
ALTER TABLE conditionchecks_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE conditionchecks_common TO nuxeo_mmi;
GRANT SELECT ON TABLE conditionchecks_common TO reader_mmi;
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckassessmentdate timestamp without time zone;
ALTER TABLE conditionchecks_common ADD COLUMN conditionchecker character varying;
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckmethod character varying;
ALTER TABLE conditionchecks_common ADD COLUMN conditionchecknote character varying;
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckreason character varying;
ALTER TABLE conditionchecks_common ADD COLUMN conditioncheckrefnumber character varying;
ALTER TABLE conditionchecks_common ADD COLUMN conservationtreatmentpriority character varying;
ALTER TABLE conditionchecks_common ADD COLUMN displayrecommendations character varying;
ALTER TABLE conditionchecks_common ADD COLUMN envrecommendations character varying;
ALTER TABLE conditionchecks_common ADD COLUMN handlingrecommendations character varying;
ALTER TABLE conditionchecks_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE conditionchecks_common ADD COLUMN legalrequirements character varying;
ALTER TABLE conditionchecks_common ADD COLUMN nextconditioncheckdate timestamp without time zone;
ALTER TABLE conditionchecks_common ADD COLUMN objectauditcategory character varying;
ALTER TABLE conditionchecks_common ADD COLUMN packingrecommendations character varying;
ALTER TABLE conditionchecks_common ADD COLUMN securityrecommendations character varying;
ALTER TABLE conditionchecks_common ADD COLUMN specialrequirements character varying;
ALTER TABLE conditionchecks_common ADD COLUMN storagerequirements character varying;

-- Mapping v2.6 MMI scopenote to v4.2 workhistorynote
ALTER TABLE works_common RENAME COLUMN scopenote TO workhistorynote;
ALTER TABLE works_common ADD COLUMN worktype character varying;

-- Adding
CREATE TABLE digitalworksgroup();
ALTER TABLE digitalworksgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE digitalworksgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE digitalworksgroup TO reader_mmi;
ALTER TABLE digitalworksgroup ADD COLUMN authoringenvironment character varying;
ALTER TABLE digitalworksgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE digitalworksgroup ADD COLUMN programminglanguage character varying;

-- Adding
CREATE TABLE envconditionnotegroup();
ALTER TABLE envconditionnotegroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE envconditionnotegroup TO nuxeo_mmi;
GRANT SELECT ON TABLE envconditionnotegroup TO reader_mmi;
ALTER TABLE envconditionnotegroup ADD COLUMN envconditionnote character varying;
ALTER TABLE envconditionnotegroup ADD COLUMN envconditionnotedate timestamp without time zone;
ALTER TABLE envconditionnotegroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE exhibitionobjectgroup();
ALTER TABLE exhibitionobjectgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitionobjectgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitionobjectgroup TO reader_mmi;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectcase character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectconscheckdate timestamp without time zone;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectconstreatment character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectmount character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectname character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectnote character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectnumber character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectrotation character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectsection character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN exhibitionobjectseqnum character varying;
ALTER TABLE exhibitionobjectgroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE exhibitionpersongroup();
ALTER TABLE exhibitionpersongroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitionpersongroup TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitionpersongroup TO reader_mmi;
ALTER TABLE exhibitionpersongroup ADD COLUMN exhibitionperson character varying;
ALTER TABLE exhibitionpersongroup ADD COLUMN exhibitionpersonrole character varying;
ALTER TABLE exhibitionpersongroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE exhibitionreferencegroup();
ALTER TABLE exhibitionreferencegroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitionreferencegroup TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitionreferencegroup TO reader_mmi;
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreference character varying;
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreferencenote character varying;
ALTER TABLE exhibitionreferencegroup ADD COLUMN exhibitionreferencetype character varying;
ALTER TABLE exhibitionreferencegroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE exhibitions_common();
ALTER TABLE exhibitions_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitions_common TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitions_common TO reader_mmi;
ALTER TABLE exhibitions_common ADD COLUMN boilerplatetext character varying;
ALTER TABLE exhibitions_common ADD COLUMN curatorialnote character varying;
ALTER TABLE exhibitions_common ADD COLUMN exhibitionnumber character varying;
ALTER TABLE exhibitions_common ADD COLUMN generalnote character varying;
ALTER TABLE exhibitions_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common ADD COLUMN planningnote character varying;
ALTER TABLE exhibitions_common ADD COLUMN title character varying;
ALTER TABLE exhibitions_common ADD COLUMN type character varying;

-- Adding
CREATE TABLE exhibitions_common_organizers();
ALTER TABLE exhibitions_common_organizers OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitions_common_organizers TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitions_common_organizers TO reader_mmi;
ALTER TABLE exhibitions_common_organizers ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_organizers ADD COLUMN item character varying;
ALTER TABLE exhibitions_common_organizers ADD COLUMN pos integer;

-- Adding
CREATE TABLE exhibitions_common_sponsors();
ALTER TABLE exhibitions_common_sponsors OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitions_common_sponsors TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitions_common_sponsors TO reader_mmi;
ALTER TABLE exhibitions_common_sponsors ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE exhibitions_common_sponsors ADD COLUMN item character varying;
ALTER TABLE exhibitions_common_sponsors ADD COLUMN pos integer;

-- Adding
CREATE TABLE exhibitionsectiongroup();
ALTER TABLE exhibitionsectiongroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitionsectiongroup TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitionsectiongroup TO reader_mmi;
ALTER TABLE exhibitionsectiongroup ADD COLUMN exhibitionsectionlocation character varying;
ALTER TABLE exhibitionsectiongroup ADD COLUMN exhibitionsectionname character varying;
ALTER TABLE exhibitionsectiongroup ADD COLUMN exhibitionsectionnote character varying;
ALTER TABLE exhibitionsectiongroup ADD COLUMN exhibitionsectionobjects character varying;
ALTER TABLE exhibitionsectiongroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE exhibitionstatusgroup();
ALTER TABLE exhibitionstatusgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE exhibitionstatusgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE exhibitionstatusgroup TO reader_mmi;
ALTER TABLE exhibitionstatusgroup ADD COLUMN exhibitionstatus character varying;
ALTER TABLE exhibitionstatusgroup ADD COLUMN exhibitionstatusdate timestamp without time zone;
ALTER TABLE exhibitionstatusgroup ADD COLUMN exhibitionstatusnote character varying;
ALTER TABLE exhibitionstatusgroup ADD COLUMN id character varying(36) NOT NULL;

-- Drop existing table that is unused in MMI v2.6 and no longer part of v4.x
DROP TABLE IF EXISTS fieldcolldepthgroup;

-- Drop existing table that is unused in MMI v2.6 and no longer part of v4.x
DROP TABLE IF EXISTS fieldcollelevationgroup;

-- Adding
CREATE TABLE filmvideocomponentsgroup();
ALTER TABLE filmvideocomponentsgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE filmvideocomponentsgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE filmvideocomponentsgroup TO reader_mmi;
ALTER TABLE filmvideocomponentsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE filmvideocomponentsgroup ADD COLUMN originalaudioformat character varying;
ALTER TABLE filmvideocomponentsgroup ADD COLUMN originalformat character varying;

-- Adding
CREATE TABLE galleryrotationgroup();
ALTER TABLE galleryrotationgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE galleryrotationgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE galleryrotationgroup TO reader_mmi;
ALTER TABLE galleryrotationgroup ADD COLUMN galleryrotationname character varying;
ALTER TABLE galleryrotationgroup ADD COLUMN galleryrotationnote character varying;
ALTER TABLE galleryrotationgroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE hazardgroup();
ALTER TABLE hazardgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE hazardgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE hazardgroup TO reader_mmi;
ALTER TABLE hazardgroup ADD COLUMN hazard character varying;
ALTER TABLE hazardgroup ADD COLUMN hazarddate timestamp without time zone;
ALTER TABLE hazardgroup ADD COLUMN hazardnote character varying;
ALTER TABLE hazardgroup ADD COLUMN id character varying(36) NOT NULL;

-- Adding
CREATE TABLE legalreqsheldgroup();
ALTER TABLE legalreqsheldgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE legalreqsheldgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE legalreqsheldgroup TO reader_mmi;
ALTER TABLE legalreqsheldgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheld character varying;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldbegindate timestamp without time zone;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldenddate timestamp without time zone;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldnumber character varying;
ALTER TABLE legalreqsheldgroup ADD COLUMN legalreqsheldrenewdate timestamp without time zone;

-- Modifying existing table
ALTER TABLE loctermgroup ADD COLUMN termformatteddisplayname character varying;

--Removing because there is no MMI v2.6 data and table no longer exists in MMI v4.x
DROP TABLE IF EXISTS nh_titlegroup;

--Removing because there is no MMI v2.6 data and table no longer exists in MMI v4.x
DROP TABLE IF EXISTS notes_common;

--Modifying existing table
ALTER TABLE orgtermgroup ADD COLUMN termformatteddisplayname character varying;

--Modifying existing table (column not used by MMI v2.6 and not in MMI v4.x)
ALTER TABLE persons_common DROP COLUMN IF EXISTS description;

--Modifying
ALTER TABLE persontermgroup ADD COLUMN termformatteddisplayname character varying;

-- WARNING: This type change may not work well: (character varying to text).
ALTER TABLE picture ALTER COLUMN caption TYPE text;

--Modifying
ALTER TABLE placetermgroup ADD COLUMN termformatteddisplayname character varying;


--Adding
CREATE TABLE publicitems_common();
ALTER TABLE publicitems_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE publicitems_common TO nuxeo_mmi;
GRANT SELECT ON TABLE publicitems_common TO reader_mmi;
ALTER TABLE publicitems_common ADD COLUMN contentaccesscountlimit bigint;
ALTER TABLE publicitems_common ADD COLUMN contentaccessedcount bigint;
ALTER TABLE publicitems_common ADD COLUMN contentcreationjobid character varying;
ALTER TABLE publicitems_common ADD COLUMN contentexpirationdate timestamp without time zone;
ALTER TABLE publicitems_common ADD COLUMN contentid character varying;
ALTER TABLE publicitems_common ADD COLUMN contentname character varying;
ALTER TABLE publicitems_common ADD COLUMN contentsource character varying;
ALTER TABLE publicitems_common ADD COLUMN contenturi character varying;
ALTER TABLE publicitems_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE publicitems_common ADD COLUMN itemnumber character varying;

--Adding
CREATE TABLE registration();
ALTER TABLE registration OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE registration TO nuxeo_mmi;
GRANT SELECT ON TABLE registration TO reader_mmi;
ALTER TABLE registration ADD COLUMN accepted boolean;
ALTER TABLE registration ADD COLUMN comment character varying;
ALTER TABLE registration ADD COLUMN copyto character varying;
ALTER TABLE registration ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE registration ADD COLUMN validationmethod character varying;

--Adding
CREATE TABLE registrationconfiguration();
ALTER TABLE registrationconfiguration OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE registrationconfiguration TO nuxeo_mmi;
GRANT SELECT ON TABLE registrationconfiguration TO reader_mmi;
ALTER TABLE registrationconfiguration ADD COLUMN allowdirectvalidationforexistinguser boolean;
ALTER TABLE registrationconfiguration ADD COLUMN allowusercreation boolean;
ALTER TABLE registrationconfiguration ADD COLUMN displaylocalregistrationtab boolean;
ALTER TABLE registrationconfiguration ADD COLUMN forcerightassignment boolean;
ALTER TABLE registrationconfiguration ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE registrationconfiguration ADD COLUMN name character varying;

--Adding
CREATE TABLE relatedconceptsgroup();
ALTER TABLE relatedconceptsgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE relatedconceptsgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE relatedconceptsgroup TO reader_mmi;
ALTER TABLE relatedconceptsgroup ADD COLUMN conceptrelationtype character varying;
ALTER TABLE relatedconceptsgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE relatedconceptsgroup ADD COLUMN relatedconcept character varying;

--Adding
CREATE TABLE salvageprioritycodegroup();
ALTER TABLE salvageprioritycodegroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE salvageprioritycodegroup TO nuxeo_mmi;
GRANT SELECT ON TABLE salvageprioritycodegroup TO reader_mmi;
ALTER TABLE salvageprioritycodegroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE salvageprioritycodegroup ADD COLUMN salvageprioritycode character varying;
ALTER TABLE salvageprioritycodegroup ADD COLUMN salvageprioritycodedate timestamp without time zone;

--Adding
CREATE TABLE status();
ALTER TABLE status OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE status TO nuxeo_mmi;
GRANT SELECT ON TABLE status TO reader_mmi;
ALTER TABLE status ADD COLUMN administrative_status character varying;
ALTER TABLE status ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE status ADD COLUMN instanceid character varying;
ALTER TABLE status ADD COLUMN serviceid character varying;
ALTER TABLE status ADD COLUMN statusmessage character varying;
ALTER TABLE status ADD COLUMN userlogin character varying;

--Modifying
ALTER TABLE taxontermgroup ADD COLUMN termformatteddisplayname character varying;

--Adding
CREATE TABLE techassessmentgroup();
ALTER TABLE techassessmentgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE techassessmentgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE techassessmentgroup TO reader_mmi;
ALTER TABLE techassessmentgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE techassessmentgroup ADD COLUMN techassessment character varying;
ALTER TABLE techassessmentgroup ADD COLUMN techassessmentdate timestamp without time zone;

--Adding
CREATE TABLE technicalchangesgroup();
ALTER TABLE technicalchangesgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE technicalchangesgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE technicalchangesgroup TO reader_mmi;
ALTER TABLE technicalchangesgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE technicalchangesgroup ADD COLUMN newsupport character varying;
ALTER TABLE technicalchangesgroup ADD COLUMN previoussupport character varying;
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchange character varying;
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchangenote character varying;
ALTER TABLE technicalchangesgroup ADD COLUMN technicalchangereason character varying;

--Removing because there is no MMI v2.6 data and the table no longer exists in MMI v4.x
DROP TABLE IF EXISTS typespecimengroup;

--Adding
CREATE TABLE userinfo();
ALTER TABLE userinfo OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE userinfo TO nuxeo_mmi;
GRANT SELECT ON TABLE userinfo TO reader_mmi;
ALTER TABLE userinfo ADD COLUMN company character varying;
ALTER TABLE userinfo ADD COLUMN email character varying;
ALTER TABLE userinfo ADD COLUMN firstname character varying;
ALTER TABLE userinfo ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE userinfo ADD COLUMN lastname character varying;
ALTER TABLE userinfo ADD COLUMN login character varying;

--Adding
CREATE TABLE userinfo_groups();
ALTER TABLE userinfo_groups OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE userinfo_groups TO nuxeo_mmi;
GRANT SELECT ON TABLE userinfo_groups TO reader_mmi;
ALTER TABLE userinfo_groups ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE userinfo_groups ADD COLUMN item character varying;
ALTER TABLE userinfo_groups ADD COLUMN pos integer;

--Adding
CREATE TABLE valuationcontrols_common();
ALTER TABLE valuationcontrols_common OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE valuationcontrols_common TO nuxeo_mmi;
GRANT SELECT ON TABLE valuationcontrols_common TO reader_mmi;
ALTER TABLE valuationcontrols_common ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE valuationcontrols_common ADD COLUMN valuationcontrolrefnumber character varying;
ALTER TABLE valuationcontrols_common ADD COLUMN valuedate timestamp without time zone;
ALTER TABLE valuationcontrols_common ADD COLUMN valuenote character varying;
ALTER TABLE valuationcontrols_common ADD COLUMN valuerenewaldate timestamp without time zone;
ALTER TABLE valuationcontrols_common ADD COLUMN valuesource character varying;
ALTER TABLE valuationcontrols_common ADD COLUMN valuetype character varying;

--Adding
CREATE TABLE valueamounts();
ALTER TABLE valueamounts OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE valueamounts TO nuxeo_mmi;
GRANT SELECT ON TABLE valueamounts TO reader_mmi;
ALTER TABLE valueamounts ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE valueamounts ADD COLUMN valueamount double precision;
ALTER TABLE valueamounts ADD COLUMN valuecurrency character varying;

--Adding
CREATE TABLE venuegroup();
ALTER TABLE venuegroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE venuegroup TO nuxeo_mmi;
GRANT SELECT ON TABLE venuegroup TO reader_mmi;
ALTER TABLE venuegroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE venuegroup ADD COLUMN venue character varying;
ALTER TABLE venuegroup ADD COLUMN venueattendance character varying;
ALTER TABLE venuegroup ADD COLUMN venueclosingdate timestamp without time zone;
ALTER TABLE venuegroup ADD COLUMN venueopeningdate timestamp without time zone;
ALTER TABLE venuegroup ADD COLUMN venueurl character varying;

--Adding
CREATE TABLE visualpreferencesgroup();
ALTER TABLE visualpreferencesgroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE visualpreferencesgroup TO nuxeo_mmi;
GRANT SELECT ON TABLE visualpreferencesgroup TO reader_mmi;
ALTER TABLE visualpreferencesgroup ADD COLUMN colorpalette character varying;
ALTER TABLE visualpreferencesgroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE visualpreferencesgroup ADD COLUMN screenresolution character varying;

--Adding
CREATE TABLE workinggroup();
ALTER TABLE workinggroup OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE workinggroup TO nuxeo_mmi;
GRANT SELECT ON TABLE workinggroup TO reader_mmi;
ALTER TABLE workinggroup ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE workinggroup ADD COLUMN workinggroupnote character varying;
ALTER TABLE workinggroup ADD COLUMN workinggrouptitle character varying;

--Modifying
ALTER TABLE worktermgroup ADD COLUMN termformatteddisplayname character varying;

--Adding
CREATE TABLE works_mmi();
ALTER TABLE works_mmi OWNER TO nuxeo_mmi;
GRANT ALL ON TABLE works_mmi TO nuxeo_mmi;
GRANT SELECT ON TABLE works_mmi TO reader_mmi;
ALTER TABLE works_mmi ADD COLUMN id character varying(36) NOT NULL;
ALTER TABLE works_mmi ADD COLUMN mmigenre character varying;
ALTER TABLE works_mmi ADD COLUMN mmimedium character varying;

--
--Alter commands for "text to character varying" changes
--

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE acquisitionfunding ALTER COLUMN acquisitionfundingsourceprovisos TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE acquisitions_common ALTER COLUMN acquisitionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE acquisitions_common ALTER COLUMN acquisitionprovisos TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE acquisitions_common ALTER COLUMN acquisitionreason TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE acquisitions_common ALTER COLUMN creditline TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocactivitygroup ALTER COLUMN assocactivitynote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocconceptgroup ALTER COLUMN assocconceptnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocculturalcontextgroup ALTER COLUMN assocculturalcontextnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocdategroup ALTER COLUMN assocdatenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocobjectgroup ALTER COLUMN assocobject TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocorganizationgroup ALTER COLUMN assocorganizationnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocpeoplegroup ALTER COLUMN assocpeoplenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocpersongroup ALTER COLUMN assocpersonnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE assocplacegroup ALTER COLUMN assocplacenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN agequalifier TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ageunit TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN assoceventname TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN assoceventnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN collection TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN contentdescription TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN contentnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN copynumber TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN distinguishingfeatures TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN editionnumber TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN fieldcollectionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN fieldcollectionnumber TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN fieldcollectionplace TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN objecthistorynote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN objectnumber TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN objectproductionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownerscontributionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipaccess TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipcategory TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipexchangemethod TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipexchangenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipexchangepricecurrency TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownershipplace TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownerspersonalexperience TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN ownerspersonalresponse TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN phase TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN physicaldescription TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN recordstatus TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN sex TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN viewerscontributionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN viewerspersonalexperience TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN viewerspersonalresponse TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common ALTER COLUMN viewersrole TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_briefdescriptions ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_comments ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_contentlanguages ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_contentorganizations ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_objectproductionreasons ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_ownersreferences ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE collectionobjects_common_viewersreferences ALTER COLUMN item TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE currentlocationgroup ALTER COLUMN currentlocationnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE groups_common ALTER COLUMN scopenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE image_metadata ALTER COLUMN user_comment TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE intakes_common ALTER COLUMN conditionchecknote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE intakes_common ALTER COLUMN entrynote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE intakes_common ALTER COLUMN fieldcollectionnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE intakes_common ALTER COLUMN insurancenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE intakes_common ALTER COLUMN packingnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE loansin_common ALTER COLUMN loaninconditions TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE loansin_common ALTER COLUMN loaninnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE loansout_common ALTER COLUMN loanoutnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE loansout_common ALTER COLUMN loanpurpose TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE loansout_common ALTER COLUMN specialconditionsofloan TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE locations_common ALTER COLUMN accessnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE locations_common ALTER COLUMN securitynote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE materialgroup ALTER COLUMN materialcomponentnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE materialgroup ALTER COLUMN materialname TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE media_common ALTER COLUMN copyrightstatement TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE media_common ALTER COLUMN description TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE media_common ALTER COLUMN title TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE movements_common ALTER COLUMN currentlocationnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE movements_common ALTER COLUMN movementnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE objectcomponentgroup ALTER COLUMN objectcomponentinformation TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE objectexit_common ALTER COLUMN exitnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE objectexit_common ALTER COLUMN packingnote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE objectnamegroup ALTER COLUMN objectnamenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE othernumber ALTER COLUMN numbervalue TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE persons_common ALTER COLUMN bionote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE persons_common ALTER COLUMN namenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE persontermgroup ALTER COLUMN nameadditions TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE persontermgroup ALTER COLUMN title TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE pictemplate ALTER COLUMN title TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE titlegroup ALTER COLUMN title TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE titletranslationsubgroup ALTER COLUMN titletranslation TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE usagegroup ALTER COLUMN usagenote TYPE character varying;

-- WARNING: This type change may not work well: (text to character varying).
-- WARNING: varchar column has no maximum length.  Setting to 1024
ALTER TABLE view ALTER COLUMN title TYPE character varying;
