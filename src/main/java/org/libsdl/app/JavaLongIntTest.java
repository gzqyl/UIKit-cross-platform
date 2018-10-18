package org.libsdl.app;

public class JavaLongIntTest {

    public void test() {
        testLongInt(
                (long) Math.pow(2.0, 50.0),
                (int) Math.pow(2.0, 30.0),
                1.0f,
                2.0f,
                1024
        );
    }

    native void testLongInt(long longParam, int intParam, float floatParam1, float floatParam2, long otherLong);
}
