package com.cc.glow.widgets

import android.content.Context
import android.content.res.TypedArray
import android.util.AttributeSet
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import com.cc.glow.R
import com.cc.glow.databinding.WidgetGlowEdittextBinding
import com.cc.glow.util.extensions.focusAndShowKeyboard
import com.cc.glow.util.extensions.setupClearButtonWithAction

class GlowEditText : ConstraintLayout {

    lateinit var binding : WidgetGlowEdittextBinding

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
        binding = WidgetGlowEdittextBinding.inflate(LayoutInflater.from(context), this, true)
        val typedArray = context.obtainStyledAttributes(attrSet, R.styleable.GlowEditText)
        setAssets(typedArray)
        typedArray.recycle()
    }

    private fun setAssets(attrSet: TypedArray) {
        binding.glowEtLabel.text = attrSet.getString(R.styleable.GlowEditText_get_label)
        binding.glowEt.setupClearButtonWithAction()
        attrSet.getInt(R.styleable.GlowEditText_android_inputType, -1).let {
            if(it != -1){
                binding.glowEt.inputType = it
            }
        }
    }

    fun openKeyboard(){
        binding.glowEt.focusAndShowKeyboard()
    }
}