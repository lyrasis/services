/**
 *  This document is a part of the source code and related artifacts
 *  for CollectionSpace, an open source collections management system
 *  for museums and related institutions:

 *  http://www.collectionspace.org
 *  http://wiki.collectionspace.org

 *  Copyright 2010 University of California at Berkeley

 *  Licensed under the Educational Community License (ECL), Version 2.0.
 *  You may not use this file except in compliance with this License.

 *  You may obtain a copy of the ECL 2.0 License at

 *  https://source.collectionspace.org/collection-space/LICENSE.txt

 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package org.collectionspace.services.common;

import java.util.*;
import org.collectionspace.services.client.IQueryManager;
import org.collectionspace.services.client.PoxPayloadIn;
import org.collectionspace.services.client.PoxPayloadOut;
import org.collectionspace.services.common.UriTemplateFactory.UriTemplateType;
import org.collectionspace.services.common.UriTemplateRegistryKey;
import org.collectionspace.services.common.api.RefName;
import org.collectionspace.services.common.api.Tools;
import org.collectionspace.services.common.authorityref.AuthorityRefList;
import org.collectionspace.services.common.context.ServiceContext;
import org.collectionspace.services.common.document.DocumentFilter;
import org.collectionspace.services.common.document.DocumentHandler;
import org.collectionspace.services.common.document.DocumentNotFoundException;
import org.collectionspace.services.common.query.QueryManager;
import org.collectionspace.services.common.vocabulary.RefNameServiceUtils;
import org.collectionspace.services.common.vocabulary.RefNameServiceUtils.AuthRefConfigInfo;
import org.collectionspace.services.config.ClientType;
import org.collectionspace.services.jaxb.AbstractCommonList;
import org.collectionspace.services.nuxeo.client.java.DocumentModelHandler;
import org.jboss.resteasy.plugins.providers.multipart.MultipartInput;
import org.jboss.resteasy.util.HttpResponseCodes;
import org.nuxeo.ecm.core.api.DocumentModel;
import org.nuxeo.ecm.core.api.DocumentModelList;
import org.nuxeo.ecm.core.api.repository.RepositoryInstance;

import javax.ws.rs.*;
import javax.ws.rs.core.*;


import org.collectionspace.services.common.config.TenantBindingConfigReaderImpl;
import org.collectionspace.services.config.service.ServiceBindingType;
import org.collectionspace.services.config.tenant.TenantBindingType;


/**
 * $LastChangedRevision:  $
 * $LastChangedDate:  $
 * Author: Laramie Crocker
 */
public abstract class ResourceBase
        extends AbstractMultiPartCollectionSpaceResourceImpl {

    public static final String CREATE = "create";
    public static final String READ = "get";
    public static final String UPDATE = "update";
    public static final String DELETE = "delete";
    public static final String LIST = "list";
    //FIXME retrieve client type from configuration
    static ClientType CLIENT_TYPE;

    /*
     * REM - 11/14/2011 - I discovered this static block of code and don't understand why it exists.  However, a side-effect of this static block is that ServiceMain is trying
     * to create a valid instance of entire CSpace services include an embedded Nuxeo instance.  This block of code seems goofy and unnecessary and probably should be removed?
     */
    static {
        try {
            // I put this in a try-catch static block instead of file-level static var initializer so that static methods of
            // *Resource classes may be called statically from test cases.
            // Without this catch, you can't even access static methods of a *Resource class for testing.
            CLIENT_TYPE = ServiceMain.getInstance().getClientType();
            //System.out.println("Static initializer in ResourceBase. CLIENT_TYPE:"+CLIENT_TYPE);
        } catch (Throwable t) {
            System.out.println("Static initializer failed in ResourceBase because not running from deployment.  OK to use Resource classes statically for tests.");
        }
    }
    
    //======================= CREATE ====================================================
    
    @POST
    public Response create(@Context ResourceMap resourceMap,
    		@Context UriInfo ui,
            String xmlPayload) {
        return this.create(null, resourceMap, ui, xmlPayload); 
    }
    
    public Response create(ServiceContext<PoxPayloadIn, PoxPayloadOut> parentCtx, // REM: 8/13/2012 - Some sub-classes will override this method -e.g., MediaResource does.
    		@Context ResourceMap resourceMap,
    		@Context UriInfo ui,
            String xmlPayload) {
    	Response result = null;
    	
        try {
            PoxPayloadIn input = new PoxPayloadIn(xmlPayload);
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext(input, ui.getQueryParameters());
            ctx.setResourceMap(resourceMap);
            if (parentCtx != null && parentCtx.getCurrentRepositorySession() != null) {
            	ctx.setCurrentRepositorySession(parentCtx.getCurrentRepositorySession()); // Reuse the current repo session if one exists
            }            
            result = create(input, ctx);
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.CREATE_FAILED);
        }
        
        return result;
    }    
    
    protected Response create(PoxPayloadIn input, ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx) {
        try {
            DocumentHandler<PoxPayloadIn, PoxPayloadOut, DocumentModel, DocumentModelList> handler = createDocumentHandler(ctx);
            UriBuilder path = UriBuilder.fromResource(this.getClass());
            return create(input, ctx, handler, path); //==> CALL implementation method, which subclasses may override.
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.CREATE_FAILED);
        }
    }

    /** Subclasses may override this overload, which gets called from @see #create(MultipartInput)   */
    protected Response create(PoxPayloadIn input,
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx,
            DocumentHandler<PoxPayloadIn, PoxPayloadOut, DocumentModel, DocumentModelList> handler,
            UriBuilder path)
            throws Exception {
        String csid = getRepositoryClient(ctx).create(ctx, handler);
        path.path("" + csid);
        Response response = Response.created(path.build()).build();
        return response;
    }

    //======================= UPDATE ====================================================
    @PUT
    @Path("{csid}")
    public byte[] update(@Context ResourceMap resourceMap, @PathParam("csid") String csid, String xmlPayload) {
        PoxPayloadOut result = null;
        ensureCSID(csid, UPDATE);
        try {
            PoxPayloadIn theUpdate = new PoxPayloadIn(xmlPayload);
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext(theUpdate);
            ctx.setResourceMap(resourceMap);
            result = update(csid, theUpdate, ctx); //==> CALL implementation method, which subclasses may override.
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.UPDATE_FAILED, csid);
        }
        return result.getBytes();
    }

    /** Subclasses may override this overload, which gets called from #udpate(String,MultipartInput)   */
    protected PoxPayloadOut update(String csid,
            PoxPayloadIn theUpdate,
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx)
            throws Exception {
        DocumentHandler handler = createDocumentHandler(ctx);
        getRepositoryClient(ctx).update(ctx, csid, handler);
        return ctx.getOutput();
    }

    /** Subclasses may override this overload, which gets called from #udpate(String,MultipartInput)   */
    protected PoxPayloadOut update(String csid,
            MultipartInput theUpdate,
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx,
            DocumentHandler handler)
            throws Exception {
        getRepositoryClient(ctx).update(ctx, csid, handler);
        return ctx.getOutput();
    }

    //======================= DELETE ====================================================
    @DELETE
    @Path("{csid}")
    public Response delete(@PathParam("csid") String csid) {
        ensureCSID(csid, DELETE);
        try {
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext();
            return delete(ctx, csid);  //==> CALL implementation method, which subclasses may override.
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.DELETE_FAILED, csid);
        }
    }

    /** subclasses may override this method, which is called from #delete(String)
     *  which handles setup of ServiceContext, and does Exception handling.  */
    protected Response delete(ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx, String csid)
            throws Exception {
    	DocumentHandler<PoxPayloadIn, PoxPayloadOut, DocumentModel, DocumentModelList> handler = createDocumentHandler(ctx);
        getRepositoryClient(ctx).delete(ctx, csid, handler);
        return Response.status(HttpResponseCodes.SC_OK).build();
    }
    
    public Response deleteWithParentCtx(ServiceContext<PoxPayloadIn, PoxPayloadOut> parentCtx,
    		String csid)
            throws Exception {
        ensureCSID(csid, DELETE);
        try {
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext();
            if (parentCtx != null && parentCtx.getCurrentRepositorySession() != null) {
            	ctx.setCurrentRepositorySession(parentCtx.getCurrentRepositorySession()); // reuse the repo session if one exists
            }
            return delete(ctx, csid);  //==> CALL implementation method, which subclasses may override.
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.DELETE_FAILED, csid);
        }
    }    

    //======================= GET ====================================================
    @GET
    @Path("{csid}")
    public byte[] get(
            @Context UriInfo ui,
            @PathParam("csid") String csid) {
        PoxPayloadOut result = null;
        ensureCSID(csid, READ);
        try {
            MultivaluedMap<String, String> queryParams = ui.getQueryParameters();
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext(queryParams);
            result = get(csid, ctx);// ==> CALL implementation method, which subclasses may override.
            if (result == null) {
                Response response = Response.status(Response.Status.NOT_FOUND).entity(
                        ServiceMessages.READ_FAILED + ServiceMessages.resourceNotFoundMsg(csid)).type("text/plain").build();
                throw new WebApplicationException(response);
            }
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.READ_FAILED, csid);
        }

        return result.getBytes();
    }

    protected PoxPayloadOut get(@PathParam("csid") String csid,
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx) throws Exception {
        PoxPayloadOut result = null;

        ensureCSID(csid, READ);
        DocumentHandler handler = createDocumentHandler(ctx);
        result = get(csid, ctx, handler);
        if (result == null) {
            String msg = "Could not find document with id = " + csid;
            if (logger.isErrorEnabled() == true) {
                logger.error(msg);
            }
            throw new DocumentNotFoundException(msg);
        }

        return result;
    }

    /** subclasses may override this method, which is called from #get(String)
     *  which handles setup of ServiceContext and DocumentHandler, and Exception handling.*/
    protected PoxPayloadOut get(String csid,
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx,
            DocumentHandler handler)
            throws Exception {
        getRepositoryClient(ctx).get(ctx, csid, handler);
        return ctx.getOutput();
    }

    //======================= GET without csid. List, search, etc. =====================================
    @GET
    public AbstractCommonList getList(@Context UriInfo ui) {
        MultivaluedMap<String, String> queryParams = ui.getQueryParameters();
        String keywords = queryParams.getFirst(IQueryManager.SEARCH_TYPE_KEYWORDS_KW);
        String advancedSearch = queryParams.getFirst(IQueryManager.SEARCH_TYPE_KEYWORDS_AS);
        AbstractCommonList list;
        if (keywords != null || advancedSearch != null) {
            list = search(queryParams, keywords, advancedSearch);
        } else {
            list = getList(queryParams);
        }
        return list;
    }
    
    protected AbstractCommonList getList(MultivaluedMap<String, String> queryParams) {
        try {
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext(queryParams);
            DocumentHandler handler = createDocumentHandler(ctx);
            getRepositoryClient(ctx).getFiltered(ctx, handler);
            AbstractCommonList list = (AbstractCommonList) handler.getCommonPartList();
            return list;
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.LIST_FAILED);
        }
    }

    protected AbstractCommonList finish_getList(ServiceContext ctx, DocumentHandler handler) {
        try {
            getRepositoryClient(ctx).getFiltered(ctx, handler);
            return (AbstractCommonList) handler.getCommonPartList();
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.LIST_FAILED);
        }
    }

    protected AbstractCommonList search(ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx,
    		DocumentHandler handler, 
    		MultivaluedMap<String, String> queryParams,
    		String keywords,
    		String advancedSearch) throws Exception {
        
        // perform a keyword search
        if (keywords != null && !keywords.isEmpty()) {
            String whereClause = QueryManager.createWhereClauseFromKeywords(keywords);
            if(Tools.isEmpty(whereClause)) {
                if (logger.isDebugEnabled()) {
                	logger.debug("The WHERE clause is empty for keywords: ["+keywords+"]");
                }
            } else {
	            DocumentFilter documentFilter = handler.getDocumentFilter();
	            documentFilter.appendWhereClause(whereClause, IQueryManager.SEARCH_QUALIFIER_AND);
	            if (logger.isDebugEnabled()) {
	                logger.debug("The WHERE clause is: " + documentFilter.getWhereClause());
	            }
            }
        }
        if (advancedSearch != null && !advancedSearch.isEmpty()) {
            String whereClause = QueryManager.createWhereClauseFromAdvancedSearch(advancedSearch);
            DocumentFilter documentFilter = handler.getDocumentFilter();
            documentFilter.appendWhereClause(whereClause, IQueryManager.SEARCH_QUALIFIER_AND);
            if (logger.isDebugEnabled()) {
                logger.debug("The WHERE clause is: " + documentFilter.getWhereClause());
            }
        }
        getRepositoryClient(ctx).getFiltered(ctx, handler);
        
        return (AbstractCommonList) handler.getCommonPartList();
    }

    protected AbstractCommonList search(MultivaluedMap<String, String> queryParams,
    		String keywords,
    		String advancedSearch) {
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx;
            AbstractCommonList result = null;
			try {
				ctx = createServiceContext(queryParams);
		        DocumentHandler handler = createDocumentHandler(ctx);
				result = search(ctx, handler, queryParams, keywords, advancedSearch);
			} catch (Exception e) {
	            throw bigReThrow(e, ServiceMessages.SEARCH_FAILED);
			}
            return result;
    }
    
    //FIXME: REM - This should not be @Deprecated since we may want to implement this -it has been on the wish list.
    @Deprecated
    public AbstractCommonList getList(List<String> csidList) {
        try {
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext();
            DocumentHandler handler = createDocumentHandler(ctx);
            getRepositoryClient(ctx).get(ctx, csidList, handler);
            return (AbstractCommonList) handler.getCommonPartList();
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.LIST_FAILED);
        }
    }

    //======================== GET : getAuthorityRefs ========================================
    @GET
    @Path("{csid}/authorityrefs")
    @Produces("application/xml")
    public AuthorityRefList getAuthorityRefs(
            @PathParam("csid") String csid,
            @Context UriInfo ui) {
        AuthorityRefList authRefList = null;
        try {
            MultivaluedMap<String, String> queryParams = ui.getQueryParameters();
            ServiceContext<PoxPayloadIn, PoxPayloadOut> ctx = createServiceContext(queryParams);
            DocumentModelHandler<PoxPayloadIn, PoxPayloadOut> handler = (DocumentModelHandler<PoxPayloadIn, PoxPayloadOut>) createDocumentHandler(ctx);
            List<AuthRefConfigInfo> authRefsInfo = RefNameServiceUtils.getConfiguredAuthorityRefs(ctx);
            authRefList = handler.getAuthorityRefs(csid, authRefsInfo);
        } catch (Exception e) {
            throw bigReThrow(e, ServiceMessages.AUTH_REFS_FAILED, csid);
        }
        return authRefList;
    }
    
    //======================== UTILITY : getDocModelForRefName ========================================
    /*
     * ResourceBase create and update calls will set the resourceMap into the service context
     * for all inheriting resource classes. Just use ServiceContext.getResourceMap() to get
     * the map, and pass it in.
     */
    public static DocumentModel getDocModelForRefName(RepositoryInstance repoSession, String refName, ResourceMap resourceMap) 
   			throws Exception, DocumentNotFoundException {
    	// TODO - we need to generalize the idea of a refName to more than Authorities and Items. 
    	RefName.AuthorityItem item = RefName.AuthorityItem.parse(refName);
    	if(item == null) {
    		return null;
    	}
    	ResourceBase resource = resourceMap.get(item.inAuthority.resource);
    	return resource.getDocModelForAuthorityItem(repoSession, item);
    }

    // THis is ugly, but prevents us parsing the refName twice. Once we make refName a little more
    // general, and less Authority(Item) specific, this will look better.
   	public DocumentModel getDocModelForAuthorityItem(RepositoryInstance repoSession, RefName.AuthorityItem item) 
   			throws Exception, DocumentNotFoundException {
   		logger.warn("Default (ResourceBase) getDocModelForAuthorityItem called - should not happen!");
   		return null;
   	}

    public DocumentModel getDocModelForRefName(RepositoryInstance repoSession, String refName) 
   			throws Exception, DocumentNotFoundException {
    	return getDocModelForAuthorityItem(repoSession, RefName.AuthorityItem.parse(refName));
    }
    
    protected String getDocType(String tenantId) {
        return getDocType(tenantId, getServiceName());
    }
    
    /**
     * Returns the Nuxeo document type associated with a specified service, within a specified tenant.
     * 
     * @param tenantId a tenant ID
     * @param serviceName a service name
     * @return the Nuxeo document type associated with that service and tenant.
     */
    // FIXME: This method may properly belong in a different services package or class.
    // Also, we need to check for any existing methods that may duplicate this one.
    protected String getDocType(String tenantId, String serviceName) {
        String docType = "";
        if (Tools.isBlank(tenantId)) {
            return docType;
        }
        ServiceBindingType sb = getTenantBindingsReader().getServiceBinding(tenantId, serviceName);
        if (sb == null) {
            return docType;
        }
        docType = sb.getObject().getName(); // Reads the Nuxeo Document Type from tenant bindings configuration
        return docType;
    }
    
    /**
     * Returns a UriRegistry entry: a map of tenant-qualified URI templates
     * for the current resource, for all tenants
     * 
     * @return a map of URI templates for the current resource, for all tenants
     */
    public Map<UriTemplateRegistryKey,Map<UriTemplateType,StoredValuesUriTemplate>> getUriRegistryEntries() {
        Map<UriTemplateRegistryKey,Map<UriTemplateType,StoredValuesUriTemplate>> uriRegistryEntriesMap =
                new HashMap<UriTemplateRegistryKey,Map<UriTemplateType,StoredValuesUriTemplate>>();
        List<String> tenantIds = getTenantIds();
        UriTemplateRegistryKey key;
        String docType = "";
        for (String tenantId : tenantIds) {
            docType = getDocType(tenantId);
            if (Tools.notBlank(docType)) {
                key = new UriTemplateRegistryKey();
                key.setTenantId(tenantId);
                key.setDocType(docType); 
                uriRegistryEntriesMap.put(key, getUriTemplateMap());
            }
        }
        return uriRegistryEntriesMap;
    }
    
   
   /**
    * Constructs and returns a map of URI templates for the current resource.
    * This map assumes that there will be only one URI template of a given type
    * ("reesource", "item", etc.) for each resource.
    * 
    * @return a map of URI templates for the current resource
    */
   protected Map<UriTemplateType,StoredValuesUriTemplate> getUriTemplateMap() {
        Map<UriTemplateType,StoredValuesUriTemplate> uriTemplateMap = new HashMap<UriTemplateType, StoredValuesUriTemplate>();
        StoredValuesUriTemplate resourceUriTemplate = getUriTemplate(UriTemplateFactory.RESOURCE);
        if (resourceUriTemplate == null) {
            return uriTemplateMap; // return an empty map
        }
        uriTemplateMap.put(resourceUriTemplate.getUriTemplateType(), resourceUriTemplate);
        return uriTemplateMap;
    }
    
    /**
     * Returns a URI template of the appropriate type, populated with the
     * current service name as one of its stored values.
     *      * 
     * @param type a URI template type
     * @return a URI template of the appropriate type.
     */
    protected StoredValuesUriTemplate getUriTemplate(UriTemplateFactory.UriTemplateType type) {
        Map<String,String> storedValuesMap = new HashMap<String,String>();
        storedValuesMap.put(UriTemplateFactory.SERVICENAME_VAR, getServiceName());
        StoredValuesUriTemplate template =
                UriTemplateFactory.getURITemplate(type, storedValuesMap);
        return template;
    }

    /**
     * Returns a list of tenant IDs, from tenant bindings configuration
     * 
     * @return a list of tenant IDs
     */
    // FIXME: This method may properly belong in a different services package or class.
    // Also, we need to check for any existing methods that may duplicate this one.
    protected List<String> getTenantIds() {
        List<String> tenantIds = new ArrayList<String>();
        String tenantId;
        Hashtable<String, TenantBindingType> tenantBindings =
                getTenantBindingsReader().getTenantBindings();
        if (tenantBindings != null && !tenantBindings.isEmpty()) {
            Enumeration keys = tenantBindings.keys();
            while (keys.hasMoreElements()) {
               tenantId = (String) keys.nextElement();
               if (Tools.notBlank(tenantId)) {
                   tenantIds.add(tenantId);
               }
            }
        }
        return tenantIds;
    }
    
    /**
     * Returns a reader for reading values from tenant bindings configuration
     * 
     * @return a tenant bindings configuration reader
     */
    protected TenantBindingConfigReaderImpl getTenantBindingsReader() {
        return ServiceMain.getInstance().getTenantBindingConfigReader();
    }


}
