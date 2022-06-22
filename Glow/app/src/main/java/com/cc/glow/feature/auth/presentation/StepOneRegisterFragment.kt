package com.cc.glow.feature.auth.presentation

import com.cc.glow.base.BaseFragment
import com.cc.glow.databinding.FragmentStepOneRegisterBinding


class StepOneRegisterFragment : BaseFragment<FragmentStepOneRegisterBinding>() {

    override fun initView() {

    }

    override fun initClicks() {
        viewBinder.etUserName.openKeyboard()
    }

    override fun setAssets() {
        
    }

    override fun getViewBinding() = FragmentStepOneRegisterBinding.inflate(layoutInflater)

}