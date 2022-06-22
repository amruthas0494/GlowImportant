package com.cc.glow.util

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager

object FragmentNavigationUtil {

    fun commitFragment(
        fragment: Fragment,
        fragmentManager: FragmentManager,
        container: Int,
        isToAdd: Boolean = false,
        isAddToBackStack: Boolean = false
    ) {
        val fragmentTransaction = fragmentManager.beginTransaction()

        if (isToAdd) {
            fragmentTransaction.add(container, fragment)
        } else {
            fragmentTransaction.replace(container, fragment)
        }
        if (isAddToBackStack) {
            fragmentTransaction.addToBackStack(fragment.javaClass.simpleName)
        }

        fragmentTransaction.commit()
    }

    fun removeFragment(
        container: Int,
        fragmentManager: FragmentManager
    ) {
        fragmentManager.findFragmentById(container)?.let { fragment ->
            val fragmentTransaction = fragmentManager.beginTransaction()
            fragmentTransaction.remove(fragment).commit()
        }
    }
}