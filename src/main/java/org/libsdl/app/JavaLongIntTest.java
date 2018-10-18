package org.libsdl.app;

public class JavaLongIntTest {

    public void test() {
        long longParam = 1024; // (long) Math.pow(2.0, 50.0);
        int intParam = 2048; // (int) Math.pow(2.0, 50.0);

        testLongInt(longParam, intParam);
    }

    native void testLongInt(long longParam, int intParam);
}
