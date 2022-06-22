package com.cc.glow.feature.common

import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.fragment.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.cc.glow.R
import com.cc.glow.base.BaseActivity
import com.cc.glow.databinding.ActivityBottomNavBinding

class BottomNavActivity : BaseActivity<ActivityBottomNavBinding>() {

    override fun preInit() {

    }

    override fun initView() {

    }

    override fun initClicks() {

    }

    override fun setAssets() {
        val navHost = supportFragmentManager.findFragmentById(R.id.navHostBottomNav) as NavHostFragment
        val appBarConfiguration = AppBarConfiguration(setOf(R.id.navigation_today, R.id.navigation_library))
        setupActionBarWithNavController(navHost.findNavController(), appBarConfiguration)
        viewBinder.navView.setupWithNavController(navHost.findNavController())
    }

    override fun getViewBinding() = ActivityBottomNavBinding.inflate(layoutInflater)


}