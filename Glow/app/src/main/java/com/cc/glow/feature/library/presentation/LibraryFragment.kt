package com.cc.glow.feature.library.presentation

import com.cc.glow.base.BaseFragment
import com.cc.glow.databinding.FragmentLibraryBinding
import com.cc.glow.util.extensions.showToast

class LibraryFragment : BaseFragment<FragmentLibraryBinding>() {

    override fun initView() {
        requireContext().showToast("LibraryFragment")
    }

    override fun initClicks() {

    }

    override fun setAssets() {

    }

    override fun getViewBinding() = FragmentLibraryBinding.inflate(layoutInflater)

}