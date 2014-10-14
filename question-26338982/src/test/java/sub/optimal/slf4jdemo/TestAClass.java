/**
 * for: http://stackoverflow.com/questions/26338982
 * 
 */
package sub.optimal.slf4jdemo;

import org.junit.Before;
import org.junit.Test;

public class TestAClass {

    ClassToTest classToTest;

    @Before
    public void setUp() {
        classToTest = new ClassToTest();
    }

    @Test
    public void testMethodToTest() {
        int i = classToTest.methodToTest();
    }
}
