package com.cc.glow.common

import android.app.Application
import com.cc.glow.data.local.pref.Preferences
import com.cc.glow.di.networkModule
import com.cc.glow.di.preferenceModule
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin

class GlowApp : Application() {

    companion object {
        var refresh = false
    }

    override fun onCreate() {
        super.onCreate()
        Preferences.init(this)
        startKoin {
            androidContext(this@GlowApp)
            modules(
                listOf(
                    preferenceModule,
                    networkModule
                )
            )
        }
    }
}