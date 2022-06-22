package com.cc.glow.util.extensions

import android.annotation.SuppressLint
import android.widget.ImageView
import androidx.appcompat.widget.AppCompatImageView
import androidx.swiperefreshlayout.widget.CircularProgressDrawable
import com.bumptech.glide.Glide
import com.bumptech.glide.Priority
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.FitCenter
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.bumptech.glide.request.RequestOptions
import com.cc.glow.R
import com.cc.glow.util.CircularTransformGlide


//Glide
@SuppressLint("CheckResult")
fun ImageView.setProfile(imagePath: Any?) {

    val progressDrawable = CircularProgressDrawable(this.context)
    progressDrawable.strokeWidth = 5f
    progressDrawable.centerRadius = 30f
    progressDrawable.start()

    val options = RequestOptions()
    options.circleCrop()
    options.placeholder(progressDrawable)
    options.fallback(R.drawable.ic_placeholder_profile_circle)
    Glide.with(this.context).load(imagePath).apply(options).into(this)
}


fun AppCompatImageView.loadBanner(imagePath: String?) {

    val options = RequestOptions()
        .diskCacheStrategy(DiskCacheStrategy.ALL)
        .placeholder(R.drawable.ic_placeholder_loading)
        .transform(CenterCrop(), RoundedCorners(5))

    Glide.with(this)
        .asBitmap()
        .load(imagePath)
        .apply(options)
        .into(this)
}

@SuppressLint("CheckResult")
fun AppCompatImageView.setImageRoundCornerCenterCrop(
    imgUrl: Any?,
    radius: Int = 0,
    placeholder: Int = R.drawable.ic_placeholder_profile_circle
) {

    val options = RequestOptions()
        .placeholder(placeholder)
        .error(placeholder)
        .diskCacheStrategy(DiskCacheStrategy.ALL)

    if (radius > 0)
        options.transform(CenterCrop(), RoundedCorners(radius))

    Glide.with(this.context)
        .load(imgUrl)
        .apply(options)
        .into(this)
}


@SuppressLint("CheckResult")
fun AppCompatImageView.setImageRoundCorner(
    imgUrl: Any?,
    radius: Int = 0,
    placeholder: Int = R.drawable.ic_placeholder_profile_circle,
    rotate: Float = -1F
) {

    //Log.d("GlideX", "setImageRoundCorner: imgUrl $imgUrl")

    val options = RequestOptions()
        .placeholder(placeholder)
        .error(placeholder)
        .diskCacheStrategy(DiskCacheStrategy.ALL)

    if (rotate != -1F) {
        Glide.with(this.context)
            .load(imgUrl)
            //.transform(RotateTransformation(context, 90F))
            .apply(options)
            .into(this)
    } else {
        if (radius > 0)
            options.transform(FitCenter(), RoundedCorners(radius))
        Glide.with(this.context)
            .load(imgUrl)
            .apply(options)
            .into(this)

    }

}

fun AppCompatImageView.setImageCircleCrop(
    imgUrl: Any?,
    placeholder: Int = R.drawable.ic_placeholder_profile_circle
) {

    val options = RequestOptions()
        .placeholder(placeholder)
        .diskCacheStrategy(DiskCacheStrategy.ALL)
        .transform(CircularTransformGlide())
        .priority(Priority.HIGH)

    Glide.with(this.context)
        .load(imgUrl)
        .apply(options)
        .into(this)
}

fun ImageView.setImageSq(imgUrl: Any?, placeholder: Int = R.drawable.ic_placeholder_profile_square) {

    val options = RequestOptions()
        .placeholder(placeholder)
        .diskCacheStrategy(DiskCacheStrategy.ALL)
        .transform(RoundedCorners(20))
        .priority(Priority.HIGH)

    Glide.with(this.context)
        .load(imgUrl)
        .apply(options)
        .into(this)
}

fun ImageView.setImage(imgUrl: Any?, placeholder: Int = R.drawable.ic_placeholder_loading) {

    val options = RequestOptions()
        .placeholder(placeholder)
        .diskCacheStrategy(DiskCacheStrategy.ALL)
        .priority(Priority.HIGH)

    Glide.with(this.context)
        .load(imgUrl)
        .apply(options)
        .into(this)
}




