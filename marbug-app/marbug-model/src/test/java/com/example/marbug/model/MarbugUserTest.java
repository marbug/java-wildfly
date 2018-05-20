package com.example.marbug.model;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class MarbugUserTest {

  MarbugUser model;
  
  @Before
  public void prepareModel() {
    model = new MarbugUser();
  }

  @Test
  public void testGetId() {
    assertEquals("id must be 0 by default", 0, model.getId());
  }

  @Test
  public void testSetId() {
    long value = 123;
    assertEquals("id must be 0 by default", 0, model.getId());
    model.setId(value);
    assertEquals("id must be", value, model.getId());
  }

  @Test
  public void testGetLogin() {
    assertNull("login must be null by default", model.getLogin());
  }

  @Test
  public void testSetLogin() {
    String value = "Some login value";
    assertNull("login must be null by default", model.getLogin());
    model.setLogin(value);
    assertEquals("login must be", value, model.getLogin());
  }

  @Test
  public void testGetPassword() {
    assertNull("password must be null by default", model.getPassword());
  }

  @Test
  public void testSetPassword() {
    String value = "Some password value";
    assertNull("password must be null by default", model.getPassword());
    model.setPassword(value);
    assertEquals("password must be", value, model.getPassword());
  }

  @Test
  public void testGetFirstName() {
    assertNull("firstName must be null by default", model.getFirstName());
  }

  @Test
  public void testSetFirstName() {
    String value = "Some firstName value";
    assertNull("firstName must be null by default", model.getFirstName());
    model.setFirstName(value);
    assertEquals("firstName must be", value, model.getFirstName());
  }

  @Test
  public void testGetLastName() {
    assertNull("lastName must be null by default", model.getLastName());
  }

  @Test
  public void testSetLastName() {
    String value = "Some lastName value";
    assertNull("lastName must be null by default", model.getLastName());
    model.setLastName(value);
    assertEquals("lastName must be", value, model.getLastName());
  }

}
