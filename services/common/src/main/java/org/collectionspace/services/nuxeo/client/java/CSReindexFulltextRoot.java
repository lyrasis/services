package org.collectionspace.services.nuxeo.client.java;

import org.nuxeo.ecm.core.ReindexFulltextRoot;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * Use the inherited reindexFulltext() method to reindex the Nuxeo full-text index.
 */
public class CSReindexFulltextRoot extends ReindexFulltextRoot {

	/** The logger. */
	private final Logger logger = LoggerFactory.getLogger(CSReindexFulltextRoot.class);

	public CSReindexFulltextRoot(CoreSessionInterface repoSession) {
		this.coreSession = repoSession.getCoreSession();
	}

}
