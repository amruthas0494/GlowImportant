package com.cc.glow.data.local.pref

open class GlowPreferences : Preferences() {

    var isLoggedIn by booleanPref(GlowPreferenceKeyEnum.IS_LOGGED_IN.value, false)
    var accessToken by stringPref(GlowPreferenceKeyEnum.ACCESS_TOKEN.value, "")
    var refreshToken by stringPref(GlowPreferenceKeyEnum.REFRESH_TOKEN.value, "")
    var userData by stringPref(GlowPreferenceKeyEnum.USER_DATA.value, null)

    fun logOut() {
        accessToken = ""
        refreshToken = ""
        isLoggedIn = false
        userData = ""
    }

    fun setLoggedIn(accessToken: String?, refreshToken: String?) {
        isLoggedIn = true
        this.accessToken = accessToken
        this.refreshToken = refreshToken
    }

    fun updateTokens(updatedAccessToken: String, updatedRefreshToken: String) {
        accessToken = updatedAccessToken
        refreshToken = updatedRefreshToken
    }

}