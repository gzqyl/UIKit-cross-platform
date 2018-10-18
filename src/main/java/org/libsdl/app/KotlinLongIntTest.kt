package org.libsdl.app

import kotlin.math.pow

class KotlinLongIntTest {
    fun test() {
        val longParam: Long = 1024 // 2.0.pow(50).toLong()
        val intParam: Int = 2048 // 2.0.pow(30).toInt()

        testLongInt(longParam, intParam)
    }
    external fun testLongInt(longParam: Long, intParam: Int)
}