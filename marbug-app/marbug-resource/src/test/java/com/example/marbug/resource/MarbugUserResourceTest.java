package com.example.marbug.resource;

import static org.junit.Assert.assertNotNull;

import org.junit.Before;
import org.junit.Test;

public class MarbugUserResourceTest {

  private MarbugUserResource resource;

  @Before
  public void prepareResource() {
    resource = new MarbugUserResource();
  }

  @Test
  public void testAdd() {
    assertNotNull("resource must be non null", resource);
  }

}
