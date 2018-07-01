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
        
}
