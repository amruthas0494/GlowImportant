package com.cc.glow.util.extensions

import android.view.View
import android.view.Window
import android.view.WindowManager
import androidx.core.content.ContextCompat
import com.cc.glow.R

fun Window.showSystemUI(isShow: Boolean = true) {
    if (isShow) {
        decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
    } else {
        decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_IMMERSIVE
                // Set the content to appear under the system bars so that the
                // content doesn't resize when the system bars hide and show.
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                // Hide the nav bar and status bar
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_LOW_PROFILE
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
    }
}

fun Window?.setFullscreen(){
    this?.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN)
    this?.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
}

fun Window?.removeFullScreen(){
    this?.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN)
    this?.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
}

fun Window?.setStatusBarColor(){

}

fun Window.keepScreenOn(isScreenOn: Boolean = true) {
    when {
        isScreenOn -> {
            addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
        else -> {
            clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }
}