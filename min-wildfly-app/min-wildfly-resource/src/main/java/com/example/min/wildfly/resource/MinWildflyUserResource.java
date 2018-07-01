package com.example.min.wildfly.resource;

import com.example.min.wildfly.model.MinWildflyUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

@Path("/v1/user")
@Api(value = "User")
@Produces(MediaType.APPLICATION_JSON)
public class MinWildflyUserResource {

  @GET
  @Path("/sign-in")
  @ApiOperation(value = "Sign in")
  public MinWildflyUser signIn() {

    MinWildflyUser model = new MinWildflyUser();

    // TODO
    model.setId(12345L);
    model.setUsername("Some username");
    model.setPassword("Some password");
    model.setEmail("Some email");

    return model;
  }
    
}
