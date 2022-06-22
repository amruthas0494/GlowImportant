package com.cc.glow.di

import com.cc.glow.data.local.pref.GlowPreferences
import org.koin.dsl.module

val preferenceModule = module {
    single { provideMynPref() }
}

fun provideMynPref() = GlowPreferences()