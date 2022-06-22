package com.cc.glow.util.extensions

import android.annotation.SuppressLint
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities


@SuppressLint("NewApi")
fun Context.hasNetwork(): Boolean {
    val manager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val capabilities = manager.getNetworkCapabilities(manager.activeNetwork)
    var isAvailable = false
    capabilities?.run {
        when {
            hasTransport(NetworkCapabilities.TRANSPORT_VPN) -> isAvailable = true
            hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> isAvailable = true
            hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> isAvailable = true
            hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> isAvailable = true
        }
    }
    return isAvailable
}