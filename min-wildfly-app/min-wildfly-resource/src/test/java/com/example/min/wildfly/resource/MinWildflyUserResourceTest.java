package com.example.min.wildfly.resource;

import static org.junit.Assert.assertNotNull;
import org.junit.Before;
import org.junit.Test;

import com.example.min.wildfly.model.MinWildflyUser;

public class MinWildflyUserResourceTest {
    
    private MinWildflyUserResource resource;
    
    @Before
    public void prepareModel() {
        resource = new MinWildflyUserResource();
    }

    @Test
    public void setIdTest() {
        MinWildflyUser user = resource.signIn();

        assertNotNull("id must be not null", user.getId());
        assertNotNull("username must be not null", user.getUsername());
        assertNotNull("password must be not null", user.getPassword());
        assertNotNull("email must be not null", user.getEmail());
    }


}
