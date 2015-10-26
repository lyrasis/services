Use the proper postgres credentials.
    *** USERNAME the postgres username should be the correct instance qualified "nuxeo" user.  Look at the CSPACE_INSTANCE_ID environment var to see what your instance ID is and use that to qualify the username -i.e., username=nuxeo${CSPACE_INSTANCE_ID}. Examples, 'nuxeo_default', 'nuxeo_mmi', etc.
	*** PASSWORD the postgres password to use is the value of the environment var DB_NUXEO_PASSWORD
	
To drop database:
    dropdb -U <db_user> <db_name>
    Ex: createdb -U nuxeo_mmi42 mmi_mmi42

To create database:
    createdb -U <db_user> <db_name>
    Ex: createdb -U nuxeo_mmi42 mmi_mmi42

To import a pg_dump file: (redirect stdout and stderr '> out 2>&1')
    psql -U <db_user> <db_name> < <pg_dump_file>
    Ex: psql -U nuxeo_mmi42 mmi_mmi42 < data\nuxeodump20151007.sql > import.out 2>&1
	
To run the merge.sql script:
    psql -U <db_user> -d <db_name> -a -f <sql_script>
    Ex: psql -U nuxeo_mmi -d mmi_mmi42 -a -f merge.sql > merge.out 2>&1
	
	
	
	
	psql -U csadmin -d mmi26_default -a -f merge.sql > merge.out 2>&1