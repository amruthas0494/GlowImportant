package com.cc.glow.feature.today.presentation

import com.cc.glow.base.BaseFragment
import com.cc.glow.databinding.FragmentTodayBinding
import com.cc.glow.util.extensions.showToast

class TodayFragment : BaseFragment<FragmentTodayBinding>() {

    override fun initView() {
        requireContext().showToast("Today Fragment")
    }

    override fun initClicks() {
        
    }

    override fun setAssets() {

    }
    
    override fun getViewBinding() = FragmentTodayBinding.inflate(layoutInflater)

}