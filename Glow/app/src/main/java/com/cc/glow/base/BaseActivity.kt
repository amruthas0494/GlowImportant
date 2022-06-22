package com.cc.glow.base

import android.os.Bundle
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentActivity
import androidx.viewbinding.ViewBinding
import com.cc.glow.feature.common.BottomNavActivity

abstract class  BaseActivity<B : ViewBinding> : AppCompatActivity() {

    lateinit var viewBinder: B

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        preInit()
        viewBinder = getViewBinding()
        setContentView(viewBinder.root)
        init()
        initView()
        initClicks()
        setAssets()
    }

    private fun init() {
    }

    protected abstract fun preInit()
    protected abstract fun initView()
    protected abstract fun initClicks()
    protected abstract fun setAssets()
    abstract fun getViewBinding(): B

}