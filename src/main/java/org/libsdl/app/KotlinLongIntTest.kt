package org.libsdl.app

import kotlin.math.pow

class KotlinLongIntTest {
    fun test() {
        testLongInt(
                2.0.pow(50).toLong(),
                2.0.pow(30).toInt(),
                1.0f,
                2.0f,
                1024
        )
    }
    external fun testLongInt(longParam: Long, intParam: Int, floatParam1: Float, floatParam2: Float, otherLong: Long)
}