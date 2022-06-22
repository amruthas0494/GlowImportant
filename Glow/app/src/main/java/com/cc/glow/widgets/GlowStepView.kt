package com.cc.glow.widgets

import android.content.Context
import android.content.res.TypedArray
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import com.cc.glow.R
import com.cc.glow.databinding.WidgetGlowStepViewBinding

class GlowStepView : ConstraintLayout{

    lateinit var binding: WidgetGlowStepViewBinding

    constructor(context: Context) : super(context)

    constructor(context: Context, attrSet: AttributeSet) : super(context, attrSet) {
        init(attrSet)
    }

    constructor(context: Context, attrSet: AttributeSet, defStyleAttr: Int) : super(
        context,
        attrSet,
        defStyleAttr
    ) {
        init(attrSet)
    }

    private fun init(attrSet: AttributeSet) {
        binding = WidgetGlowStepViewBinding.inflate(LayoutInflater.from(context), this, true)
        val typedArray = context.obtainStyledAttributes(attrSet, R.styleable.GlowStepView)
        setAssets(typedArray)
        typedArray.recycle()
    }

    private fun setAssets(attrSet: TypedArray) {
        binding.glowStepViewTitle.text = attrSet.getString(R.styleable.GlowStepView_stepView_title)
        binding.glowStepViewMsg.text = attrSet.getString(R.styleable.GlowStepView_stepView_message)
    }

}