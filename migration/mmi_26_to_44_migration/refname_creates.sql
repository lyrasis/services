--
-- This SQL script creates a 'refname' value for each record in the system.  Refnames for each record
-- became part of the standard field set after the v2.6 release of CollectionSpace.
--

-- acquisitions
-- 'acquisitionreferencenumber' is being used as the default display name (as configured in the tenant bindings) for
-- acquisition records
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:acquisitions:id('
        || regexp_replace(csc.uri, '\/acquisitions\/', '') || ')'''
        || ac.acquisitionreferencenumber || ''''
from acquisitions_common ac
join collectionspace_core csc on csc.id = ac.id
where collectionspace_core.id = ac.id
and collectionspace_core.refname is null;

-- blobs
/* produces incorrect format. see revised update below
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:blobs:id('
        || regexp_replace(csc.uri, '\/blobs\/', '') || ')'
from blobs_common bc
join collectionspace_core csc on csc.id = bc.id                                 
where collectionspace_core.id = bc.id;
*/

-- blobs
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:blobs:id('
        || regexp_replace(csc.uri, '\/blobs\/', '') || ')'
from blobs_common bc
join collectionspace_core csc on csc.id = bc.id                                 
where collectionspace_core.id = bc.id
and collectionspace_core.refname is null;

-- relations
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:relations:id('
        || regexp_replace(csc.uri, '\/relations\/', '') || ')'
from relations_common rc
join collectionspace_core csc on csc.id = rc.id                                 
where collectionspace_core.id = rc.id
and collectionspace_core.refname is null;

-- intakes
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:intakes:id('
        || regexp_replace(csc.uri, '\/intakes\/', '') || ')'
from intakes_common ic
join collectionspace_core csc on csc.id = ic.id                                 
where collectionspace_core.id = ic.id
and collectionspace_core.refname is null;

-- collection objects
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:collectionobjects:id('
        || regexp_replace(csc.uri, '\/collectionobjects\/', '') || ')'''
        || coc.objectnumber || ''''
from collectionobjects_common coc
join collectionspace_core csc on csc.id = coc.id
where collectionspace_core.id = coc.id
and collectionspace_core.refname is null;

-- groups
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:groups:id('
        || regexp_replace(csc.uri, '\/groups\/', '') || ')'''
        || gc.title || ''''
from groups_common gc
join collectionspace_core csc on csc.id = gc.id
where collectionspace_core.id = gc.id
and collectionspace_core.refname is null;

-- loans in
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:loansin:id('
        || regexp_replace(csc.uri, '\/loansin\/', '') || ')'''
        || lic.loaninnumber || ''''
from loansin_common lic
join collectionspace_core csc on csc.id = lic.id
where collectionspace_core.id = lic.id
and collectionspace_core.refname is null;

-- loans out
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:loansout:id('
        || regexp_replace(csc.uri, '\/loansout\/', '') || ')'''
        || loc.loanoutnumber || ''''
from loansout_common loc
join collectionspace_core csc on csc.id = loc.id
where collectionspace_core.id = loc.id
and collectionspace_core.refname is null;

-- media
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:media:id('
        || regexp_replace(csc.uri, '\/media\/', '') || ')'''
        || mc.identificationnumber || ''''
from media_common mc
join collectionspace_core csc on csc.id = mc.id
where collectionspace_core.id = mc.id
and collectionspace_core.refname is null;

-- media where identificationnumber is null

update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:media:id('
        || regexp_replace(csc.uri, '\/media\/', '') || ')'
from media_common mc
join collectionspace_core csc on csc.id = mc.id
where collectionspace_core.id = mc.id
and collectionspace_core.refname is null
and mc.identificationnumber is null;

-- movements
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:movements:id('
        || regexp_replace(csc.uri, '\/movements\/', '') || ')'''
        || mc.movementreferencenumber || ''''
from movements_common mc
join collectionspace_core csc on csc.id = mc.id
where collectionspace_core.id = mc.id
and collectionspace_core.refname is null;

-- movements with null movementreferencenumbers
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:movements:id('
        || regexp_replace(csc.uri, '\/movements\/', '') || ')'
from movements_common mc
join collectionspace_core csc on csc.id = mc.id
where collectionspace_core.id = mc.id
and collectionspace_core.refname is null
and mc.movementreferencenumber is null;

-- movements with empty movementreferencenumbers
update collectionspace_core
set refname = regexp_replace(refname, '''''$', '')
where uri like '/movements/%'
and refname like '%)''''';

-- objectexit
update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:objectexit:id('
        || regexp_replace(csc.uri, '\/objectexit\/', '') || ')'''
        || oec.exitnumber || ''''
from objectexit_common oec
join collectionspace_core csc on csc.id = oec.id
where collectionspace_core.id = oec.id
and collectionspace_core.refname is null;

-- workauthorities
update collectionspace_core
set refname = wac.refname
from workauthorities_common wac
where collectionspace_core.id = wac.id
and collectionspace_core.refname is null;

-- works_common (work items)
update collectionspace_core
set refname = wac.refname
from works_common wac
where collectionspace_core.id = wac.id
and collectionspace_core.refname is null;

-- concept authorities
update collectionspace_core
set refname = cac.refname
from conceptauthorities_common cac
where collectionspace_core.id = cac.id
and collectionspace_core.refname is null;

-- concepts
update collectionspace_core
set refname = cc.refname
from concepts_common cc
where collectionspace_core.id = cc.id
and collectionspace_core.refname is null;

-- locationauthorities
update collectionspace_core
set refname = lac.refname
from locationauthorities_common lac
where collectionspace_core.id = lac.id
and collectionspace_core.refname is null;

-- locations
update collectionspace_core
set refname = lc.refname
from locations_common lc
where collectionspace_core.id = lc.id
and collectionspace_core.refname is null;

-- orgauthorities
update collectionspace_core
set refname = oac.refname
from orgauthorities_common oac
where collectionspace_core.id = oac.id
and collectionspace_core.refname is null;

-- organizations
update collectionspace_core
set refname = oc.refname
from organizations_common oc
where collectionspace_core.id = oc.id
and collectionspace_core.refname is null;

-- organizations and persons contact names
-- joined with hierarchy because most records did not have a value in uri

update collectionspace_core
set refname =
        'urn:cspace:movingimage.us:contacts:id('
        || h.name || ')'
from contacts_common cc
join collectionspace_core csc on csc.id = cc.id
join hierarchy h on h.id = cc.id
where collectionspace_core.id = cc.id
and collectionspace_core.refname is null;

-- personauthorities
update collectionspace_core
set refname = pac.refname
from personauthorities_common pac
where collectionspace_core.id = pac.id
and collectionspace_core.refname is null;

-- persons
update collectionspace_core
set refname = pc.refname
from persons_common pc
where collectionspace_core.id = pc.id
and collectionspace_core.refname is null;

-- persons contact names
-- ??? no persons_common_contactnames table ???

-- placeauthorities
update collectionspace_core
set refname = pac.refname
from placeauthorities_common pac
where collectionspace_core.id = pac.id
and collectionspace_core.refname is null;

-- places
update collectionspace_core
set refname = pc.refname
from places_common pc
where collectionspace_core.id = pc.id
and collectionspace_core.refname is null;

-- vocabularies
update collectionspace_core
set refname = vc.refname
from vocabularies_common vc
where collectionspace_core.id = vc.id
and collectionspace_core.refname is null;

-- vocabularyitems
update collectionspace_core
set refname = vic.refname
from vocabularyitems_common vic
where collectionspace_core.id = vic.id
and collectionspace_core.refname is null;

