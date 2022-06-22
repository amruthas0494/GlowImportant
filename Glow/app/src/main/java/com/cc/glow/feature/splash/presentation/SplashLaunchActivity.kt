package com.cc.glow.feature.splash.presentation

import androidx.lifecycle.lifecycleScope
import com.cc.glow.base.BaseActivity
import com.cc.glow.databinding.ActivitySplashLaunchBinding
import com.cc.glow.feature.auth.presentation.AuthActivity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class SplashLaunchActivity : BaseActivity<ActivitySplashLaunchBinding>() {

    override fun preInit() {

    }

    override fun initView() {
        lifecycleScope.launch {
            withContext(Dispatchers.IO){
                delay(1000)
                withContext(Dispatchers.Main){
                    AuthActivity.present(this@SplashLaunchActivity)
                    finish()
                }
            }
        }
    }

    override fun initClicks() {
        
    }

    override fun setAssets() {
        
    }

    override fun getViewBinding() = ActivitySplashLaunchBinding.inflate(layoutInflater)
}