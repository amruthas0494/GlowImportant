package com.cc.glow.feature.auth.presentation

import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.fragment.findNavController
import com.cc.glow.R
import com.cc.glow.base.BaseActivity
import com.cc.glow.databinding.ActivityAuthBinding
import com.cc.glow.util.extensions.setStatusBarColor

class AuthActivity : BaseActivity<ActivityAuthBinding>() {

    companion object{
        fun present(context : Context){
            context.startActivity(Intent(context, AuthActivity::class.java))
        }
    }

    override fun preInit() {

    }

    override fun initView() {
        val navHost = supportFragmentManager.findFragmentById(R.id.authFragContainer) as NavHostFragment
        navHost.findNavController().setGraph(R.navigation.nav_auth, intent?.extras)
    }

    override fun initClicks() {
        
    }

    override fun setAssets() {
        
    }

    override fun getViewBinding() = ActivityAuthBinding.inflate(layoutInflater)


}