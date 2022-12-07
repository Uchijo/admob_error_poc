package com.example.admob_error_poc

import android.content.Context
import android.view.LayoutInflater
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class AdmobTestFactory(val context: Context): GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.admob_native_test, null) as NativeAdView

        with(nativeAdView) {
            val iconView = findViewById<ImageView>(R.id.iv_icon)
            val icon = nativeAd.icon
            val mainImageView = findViewById<ImageView>(R.id.iv_mainimage)
            val mainImage = nativeAd.images[0]
            if (icon != null || mainImage != null) {
                iconView.setImageDrawable(icon!!.drawable)
                mainImageView.setImageDrawable(mainImage.drawable)
            }
            this.iconView = iconView

            val headlineView = findViewById<TextView>(R.id.tv_headline)
            headlineView.text = nativeAd.headline
            this.headlineView = headlineView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}