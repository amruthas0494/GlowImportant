package com.cc.glow.di

import com.cc.glow.BuildConfig
import com.cc.glow.data.local.pref.GlowPreferences
import com.cc.glow.data.remote.AuthService
import com.cc.glow.data.remote.FeedService
import com.cc.glow.network.jsonadapter.NullToEmptyStringAdapter
import com.cc.glow.network.jsonadapter.StringToBooleanAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.CertificatePinner
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.core.qualifier.named
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import java.security.SecureRandom
import java.security.cert.X509Certificate
import javax.net.ssl.HostnameVerifier
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

val networkModule = module {
    single { provideHttpClient(get(), get()) }
    single { provideLoggingInterceptor() }
    single { provideAuthInterceptor() }
    single { providesMoshi() }
    single { provideRetrofit(get(), get()) }
    single { provideAuthService(get((named("auth")))) }
    single { provideFeedService(get((named("feed")))) }
}

private fun provideAuthService(retrofit: Retrofit): AuthService =
    retrofit.create(AuthService::class.java)

private fun provideFeedService(retrofit: Retrofit): FeedService =
    retrofit.create(FeedService::class.java)

fun providesMoshi(): Moshi {
    return Moshi.Builder()
        .add(StringToBooleanAdapter())
        .add(NullToEmptyStringAdapter())
        .add(KotlinJsonAdapterFactory())
        .build()
}

fun provideHttpClient(
    httpLoggingInterceptor: HttpLoggingInterceptor,
    authInterceptor: Interceptor
): OkHttpClient {
    return OkHttpClient.Builder()
        .certificatePinner(certificatePinner)
        .addInterceptor(httpLoggingInterceptor)
        .addInterceptor(authInterceptor)
        .ignoreAllSSLErrors()
        .build()
}

fun provideLoggingInterceptor(): HttpLoggingInterceptor {
    return HttpLoggingInterceptor().apply {
        level = HttpLoggingInterceptor.Level.BODY
    }
}

fun provideAuthInterceptor(): Interceptor {

    return object : Interceptor {
        override fun intercept(chain: Interceptor.Chain): Response {

            val accessToken = GlowPreferences().accessToken
            val isLoggedIn = GlowPreferences().isLoggedIn

            val newRequest = chain.request().newBuilder().build()

                /* Log.d("Network", "intercept: accessToken $accessToken isLoggedIn $isLoggedIn")

                 val newRequest = if (MynPreferences().isLoggedIn) {
                     chain.request().newBuilder()
                         .addHeader("API-Key", BuildConfig.API_TOKEN)
                         .addHeader("authtoken", accessToken!!)
                         .build()
                 } else
                     chain.request().newBuilder()
                         .addHeader("API-Key", BuildConfig.API_TOKEN)
                         .build()*/

            return chain.proceed(newRequest)
        }
    }

}

fun provideRetrofit(factory: Moshi, client: OkHttpClient): Retrofit {
    return Retrofit.Builder()
        .baseUrl(BuildConfig.BASE_URL)
        .addConverterFactory(MoshiConverterFactory.create(factory))
        .client(client)
        .build()
}

// TODO: 12/10/21 - Change certificate
private val certificatePinner = CertificatePinner.Builder()
    .add(
        "glow.xyz",
        "sha256/D9sXWtyclyg2qztU3XjuiUfHn7vXv7+uSLJy+HM8GWc="
    )
    .build()

fun OkHttpClient.Builder.ignoreAllSSLErrors(): OkHttpClient.Builder {
    val naiveTrustManager = object : X509TrustManager {
        override fun getAcceptedIssuers(): Array<X509Certificate> = arrayOf()
        override fun checkClientTrusted(certs: Array<X509Certificate>, authType: String) = Unit
        override fun checkServerTrusted(certs: Array<X509Certificate>, authType: String) = Unit
    }

    val insecureSocketFactory = SSLContext.getInstance("SSL").apply {
        val trustAllCerts = arrayOf<TrustManager>(naiveTrustManager)
        init(null, trustAllCerts, SecureRandom())
    }.socketFactory

    sslSocketFactory(insecureSocketFactory, naiveTrustManager)
    hostnameVerifier(HostnameVerifier { hostname, session -> true })
    return this
}
