package main.java.org.libsdl.app

import android.util.Log
import android.view.InputDevice
import android.view.MotionEvent
import android.view.View
import org.libsdl.app.JavaLongIntTest
import org.libsdl.app.KotlinLongIntTest
import org.libsdl.app.SDLActivity
import java.lang.Math.pow
import kotlin.math.min
import kotlin.math.pow


private const val tag: String = "SDLOnTouchListener"

private data class TouchValues(val fingerId: Int, val x: Float, val y: Float, val p: Float)

private fun MotionEvent.touchValues(i: Int): TouchValues {
    return TouchValues(
            this.getPointerId(i),
            this.getX(i),
            this.getY(i),
            // Pressure can be > 1.0 on some devices. See getPressure(i) docs.
            min(this.getPressure(i), 1.0f)
    )
}

interface SDLOnTouchListener: View.OnTouchListener {

    var mWidth: Float
    var mHeight: Float

    fun onNativeMouse(button: Int, action: Int, x: Float, y: Float)
    fun onNativeTouch(touchDevId: Int, pointerFingerId: Int, action: Int, x: Float, y: Float, p: Float, t: Long)

    // Touch events
    override fun onTouch(v: View, event: MotionEvent): Boolean {

        JavaLongIntTest().test()
        KotlinLongIntTest().test()

        /* Ref: http://developer.android.com/training/gestures/multi.html */
        val touchDevId = event.deviceId
        val action = event.actionMasked

        val time: Long = 1024 // event.eventTime()
        Log.i(tag, "timestamp: " + time.toString())


        if (event.source == InputDevice.SOURCE_MOUSE && SDLActivity.mSeparateMouseAndTouch) {
            val mouseButton = try { event.buttonState } catch (e: Exception) { 1 } // 1 is left button
            this.onNativeMouse(mouseButton, action, event.getX(0), event.getY(0))
            return true
        }

        when (action) {
            MotionEvent.ACTION_MOVE -> {
                for (i in 0 until event.pointerCount) {
                    val (fingerId, x, y, p) = event.touchValues(i)
                    Log.i(tag, "pressure: "  + p.toString())
                    this.onNativeTouch(touchDevId, fingerId, action, x, y, p, time)
                }
            }

            MotionEvent.ACTION_UP, MotionEvent.ACTION_DOWN -> {
                // Primary pointer up/down, the index is always zero
                val (fingerId, x, y, p) = event.touchValues(event.actionIndex)
                this.onNativeTouch(touchDevId, fingerId, action, x, y, p, time)
            }

            MotionEvent.ACTION_POINTER_UP, MotionEvent.ACTION_POINTER_DOWN -> {
                val (fingerId, x, y, p) = event.touchValues(event.actionIndex)
                this.onNativeTouch(touchDevId, fingerId, action, x, y, p, time)
            }

            MotionEvent.ACTION_CANCEL -> {
                for (i in 0 until event.pointerCount) {
                    val (fingerId, x, y, p) = event.touchValues(i)
                    this.onNativeTouch(touchDevId, fingerId, MotionEvent.ACTION_UP, x, y, p, time)
                }
            }
        }

        return true
    }
}