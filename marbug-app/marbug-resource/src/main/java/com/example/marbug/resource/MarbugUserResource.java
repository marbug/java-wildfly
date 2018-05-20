package com.example.marbug.resource;

import com.example.marbug.model.MarbugUser;
import io.swagger.annotations.ApiOperation;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

@Path("/v1")
public class MarbugUserResource {

  @Context
  private UriInfo uriInfo;

  @GET
  @Path("/file")
  @ApiOperation(value = "Add/register new user")
  public MarbugUser add() {
    MarbugUser user = new MarbugUser();
    return user;
  }
  
}
