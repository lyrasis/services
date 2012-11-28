package org.collectionspace.services.nuxeo.extension.botgarden;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.collectionspace.services.batch.nuxeo.FormatTaxonBatchJob;
import org.collectionspace.services.batch.nuxeo.FormatVoucherNameBatchJob;
import org.collectionspace.services.common.ResourceMap;
import org.collectionspace.services.loanout.nuxeo.LoanoutConstants;
import org.collectionspace.services.taxonomy.nuxeo.TaxonConstants;
import org.jboss.resteasy.spi.ResteasyProviderFactory;
import org.nuxeo.ecm.core.api.ClientException;
import org.nuxeo.ecm.core.api.DocumentModel;
import org.nuxeo.ecm.core.api.event.CoreEventConstants;
import org.nuxeo.ecm.core.api.event.DocumentEventTypes;
import org.nuxeo.ecm.core.event.Event;
import org.nuxeo.ecm.core.event.EventContext;
import org.nuxeo.ecm.core.event.EventListener;
import org.nuxeo.ecm.core.event.impl.DocumentEventContext;

public class UpdateFormattedDisplayNameListener implements EventListener {
	public static final String RUN_AFTER_MODIFIED_PROPERTY = "UpdateFormattedDisplayNameListener.RUN_AFTER_MODIFIED";

	private static final String[] DISPLAY_NAME_PATH_ELEMENTS = TaxonConstants.DISPLAY_NAME_FIELD_NAME.split("/");
	private static final String TERM_GROUP_LIST_FIELD_NAME = DISPLAY_NAME_PATH_ELEMENTS[0];
	private static final String TERM_GROUP_FIELD_NAME = DISPLAY_NAME_PATH_ELEMENTS[1];
	private static final String DISPLAY_NAME_FIELD_NAME = DISPLAY_NAME_PATH_ELEMENTS[2];
	
	private static final String[] FORMATTED_DISPLAY_NAME_PATH_ELEMENTS = TaxonConstants.FORMATTED_DISPLAY_NAME_FIELD_NAME.split("/");
	private static final String FORMATTED_DISPLAY_NAME_FIELD_NAME = FORMATTED_DISPLAY_NAME_PATH_ELEMENTS[2];

	final Log logger = LogFactory.getLog(UpdateFormattedDisplayNameListener.class);
	
	public void handleEvent(Event event) throws ClientException {
		EventContext ec = event.getContext();

		if (ec instanceof DocumentEventContext) {
			DocumentEventContext context = (DocumentEventContext) ec;
			DocumentModel doc = context.getSourceDocument();

			logger.debug("docType=" + doc.getType());
			
			if (doc.getType().startsWith(TaxonConstants.NUXEO_DOCTYPE) && 
					!doc.isVersion() && 
					!doc.isProxy() && 
					!doc.getCurrentLifeCycleState().equals(LoanoutConstants.DELETED_STATE)) {
				
				if (event.getName().equals(DocumentEventTypes.DOCUMENT_CREATED)) {
					// Save the document, to get the BEFORE_DOC_UPDATE branch to run.
					doc.getCoreSession().saveDocument(doc);
				}
				else if (event.getName().equals(DocumentEventTypes.BEFORE_DOC_UPDATE)) {
					DocumentModel previousDoc = (DocumentModel) context.getProperty(CoreEventConstants.PREVIOUS_DOCUMENT_MODEL);	            	

					updateFormattedDisplayNames(doc, previousDoc);
				}
			}
		}
	}
	
	private void updateFormattedDisplayNames(DocumentModel doc, DocumentModel previousDoc) throws ClientException {
		//Set<String> previousDisplayNames = getDisplayNames(previousDoc);
		FormatTaxonBatchJob formatter = createFormatter();
		List<Map<String, Object>> termGroupList = (List<Map<String, Object>>) doc.getProperty(TaxonConstants.DISPLAY_NAME_SCHEMA_NAME, TERM_GROUP_LIST_FIELD_NAME);

		for (Map<String, Object> termGroup : termGroupList) {
			String displayName = (String) termGroup.get(DISPLAY_NAME_FIELD_NAME);
			String formattedDisplayName = (String) termGroup.get(FORMATTED_DISPLAY_NAME_FIELD_NAME);
			
			if (StringUtils.isBlank(formattedDisplayName)) {
				formattedDisplayName = "";
				
				if (StringUtils.isNotBlank(displayName)) {
					formattedDisplayName = formatter.applyStyles(displayName);
				}
	
				termGroup.put(FORMATTED_DISPLAY_NAME_FIELD_NAME, formattedDisplayName);
			}
		}
		
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put(TERM_GROUP_LIST_FIELD_NAME, termGroupList);
		
		doc.setProperties(TaxonConstants.DISPLAY_NAME_SCHEMA_NAME, updateMap);
	}
	
	private Set<String> getDisplayNames(DocumentModel doc) throws ClientException {
		Set<String> displayNames = new HashSet<String>();
		List<Map<String, Object>> termGroupList = (List<Map<String, Object>>) doc.getProperty(TaxonConstants.DISPLAY_NAME_SCHEMA_NAME, TERM_GROUP_LIST_FIELD_NAME);

		for (Map<String, Object> termGroup : termGroupList) {
			String displayName = (String) termGroup.get(DISPLAY_NAME_FIELD_NAME);
			
			if (displayName != null) {
				displayNames.add(displayName);
			}
		}
		
		return displayNames;
	}
	
	private FormatTaxonBatchJob createFormatter() {
		FormatTaxonBatchJob formatter = new FormatTaxonBatchJob();

		return formatter;
	}
}