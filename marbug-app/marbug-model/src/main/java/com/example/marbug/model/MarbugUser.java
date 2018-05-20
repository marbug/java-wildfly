package com.example.marbug.model;

import java.io.Serializable;

public class MarbugUser implements Serializable {

  private static final long serialVersionUID = 1L;

  private long id;
  private String login;
  private String password;
  private String firstName;
  private String lastName;

  public long getId() {
    return id;
  }
  public void setId(long id) {
    this.id = id;
  }
  public String getLogin() {
    return login;
  }
  public void setLogin(String login) {
    this.login = login;
  }
  public String getPassword() {
    return password;
  }
  public void setPassword(String password) {
    this.password = password;
  }
  public String getFirstName() {
    return firstName;
  }
  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }
  public String getLastName() {
    return lastName;
  }
  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

}
