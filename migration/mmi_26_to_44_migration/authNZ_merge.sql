-- db1: {cspace_default localhost 5432 csadmin cs1dn3b sslmode=disable}
-- db2: {mmi26_cspace_default localhost 5432 csadmin cs1dn3b sslmode=disable}
-- Run the following SQL againt db2:
ALTER TABLE accounts_tenants RENAME COLUMN tenants_accountscommon_csid TO tenants_accounts_common_csid;
--
-- Create the 'disabled' column with a not-null constraint and default value of 'false'
ALTER TABLE tenants ADD COLUMN disabled boolean;
ALTER TABLE tenants ALTER COLUMN disabled SET DEFAULT false;
ALTER TABLE tenants ALTER COLUMN disabled DROP NOT NULL;

-- Set the current tenants' 'disabled' column values to 'false'
UPDATE tenants SET disabled=false;

-- Fix the role name and display name for the tenant admin super role.
UPDATE roles SET rolename='ROLE_0_ALL_TENANTS_MANAGER' WHERE rolename='ROLE_0_ADMINISTRATOR';
UPDATE roles SET displayname= 'ALL_TENANTS_MANAGER' WHERE displayname='ADMINISTRATOR';

-- Set admin password to "Administrator" so we can login and test things.
UPDATE users SET passwd='59PnafP1k9rcuGNMxbCfyQ3TphxKBqecsJI2Yv5vrms=' WHERE username='admin@movingimage.us';
