package com.example.min.wildfly.model;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import org.junit.Before;
import org.junit.Test;

public class MinWildflyUserTest {

    private MinWildflyUser model;
    
    @Before
    public void prepareModel() {
        model = new MinWildflyUser();
    }

    @Test
    public void setIdTest() {
        Long id = model.getId();
        assertNull("id must be null", id);

        Long value = 123L;
        model.setId(value);

        assertEquals("id must be", value, model.getId());
    }

    @Test
    public void setUsernameTest() {
        String username = model.getUsername();
        assertNull("username must be null", username);

        String value = "Some username value";
        model.setUsername(value);

        assertEquals("username must be", value, model.getUsername());
    }

    @Test
    public void setPasswordTest() {
        String username = model.getPassword();
        assertNull("username must be null", username);

        String value = "Some username value";
        model.setPassword(value);

        assertEquals("username must be", value, model.getPassword());
    }

    @Test
    public void setEmailTest() {
        String username = model.getEmail();
        assertNull("username must be null", username);

        String value = "Some username value";
        model.setEmail(value);

        assertEquals("username must be", value, model.getEmail());
    }

}
