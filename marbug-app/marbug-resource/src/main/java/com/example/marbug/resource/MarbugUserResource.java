package com.example.marbug.resource;

import com.example.marbug.model.MarbugUser;
import io.swagger.v3.oas.annotations.Operation;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/v1")
@Produces({"application/json", "application/xml"})
public class MarbugUserResource {

  @GET
  @Path("/file")
  @Operation(
          summary = "Add/register new user",
          description = "Allows to add (i.e. register) new user"
  )
  public MarbugUser add() {
    MarbugUser user = new MarbugUser();
    return user;
  }
  
}
