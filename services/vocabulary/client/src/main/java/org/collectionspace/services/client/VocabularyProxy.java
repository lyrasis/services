package org.collectionspace.services.client;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
//import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
//import javax.ws.rs.core.UriInfo;

import org.collectionspace.services.common.query.IQueryManager;
import org.collectionspace.services.vocabulary.VocabulariesCommonList;
import org.collectionspace.services.vocabulary.VocabularyitemsCommonList;
import org.jboss.resteasy.client.ClientResponse;

/**
 * @version $Revision:$
 */
//@Path("/vocabularies/")
@Path("/" + VocabularyClient.SERVICE_PATH_COMPONENT + "/")
@Produces({"application/xml"})
@Consumes({"application/xml"})
public interface VocabularyProxy extends CollectionSpaceProxy {

    // List Vocabularies
    @GET
    @Produces({"application/xml"})
    ClientResponse<VocabulariesCommonList> readList();

    //(C)reate
    @POST
    ClientResponse<Response> create(String xmlPayload);

    //(R)ead
    @GET
    @Path("/{csid}")
    ClientResponse<String> read(@PathParam("csid") String csid);

    //(R)ead by name
    @GET
    @Path("/urn:cspace:name({name})")
    ClientResponse<String> readByName(@PathParam("name") String name);

    //(U)pdate
    @PUT
    @Path("/{csid}")
    ClientResponse<String> update(@PathParam("csid") String csid, String xmlPayload);

    //(D)elete
    @DELETE
    @Path("/{csid}")
    ClientResponse<Response> delete(@PathParam("csid") String csid);

    // List Items matching a partial term or keywords.
    @GET
    @Produces({"application/xml"})
    @Path("/{vcsid}/items/")
    ClientResponse<VocabularyitemsCommonList> readItemList(
    		@PathParam("vcsid") String vcsid,
            @QueryParam (IQueryManager.SEARCH_TYPE_PARTIALTERM) String partialTerm,
            @QueryParam(IQueryManager.SEARCH_TYPE_KEYWORDS_KW) String keywords);
    
    // List Items for a named authority matching a partial term or keywords.
    @GET
    @Produces({"application/xml"})
    @Path("/urn:cspace:name({specifier})/items")
    ClientResponse<VocabularyitemsCommonList> readItemListForNamedVocabulary(
    		@PathParam("specifier") String specifier,
            @QueryParam (IQueryManager.SEARCH_TYPE_PARTIALTERM) String partialTerm,
            @QueryParam(IQueryManager.SEARCH_TYPE_KEYWORDS_KW) String keywords);

    //(C)reate Item
    @POST
    @Path("/{vcsid}/items/")
    ClientResponse<Response> createItem(@PathParam("vcsid") String vcsid, String xmlPayload);

    //(R)ead
    @GET
    @Path("/{vcsid}/items/{csid}")
    ClientResponse<String> readItem(@PathParam("vcsid") String vcsid, @PathParam("csid") String csid);

    //(U)pdate
    @PUT
    @Path("/{vcsid}/items/{csid}")
    ClientResponse<String> updateItem(@PathParam("vcsid") String vcsid, @PathParam("csid") String csid, String xmlPayload);

    //(D)elete
    @DELETE
    @Path("/{vcsid}/items/{csid}")
    ClientResponse<Response> deleteItem(@PathParam("vcsid") String vcsid, @PathParam("csid") String csid);
}
