package com.cc.glow.util.extensions

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.ObjectAnimator
import android.content.Context
import android.content.Context.INPUT_METHOD_SERVICE
import android.content.ContextWrapper
import android.graphics.Typeface
import android.graphics.drawable.Drawable
import android.os.Parcelable
import android.util.DisplayMetrics
import android.util.SparseArray
import android.util.TypedValue
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.TranslateAnimation
import android.view.inputmethod.InputMethodManager
import android.view.inputmethod.InputMethodManager.SHOW_IMPLICIT
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.content.res.AppCompatResources
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.appcompat.widget.Toolbar
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.core.view.ViewCompat
import androidx.core.view.children
import androidx.core.widget.NestedScrollView
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.appbar.AppBarLayout
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.android.material.tabs.TabLayout


fun View.show() {
    visibility = View.VISIBLE
}

fun View.hide() {
    visibility = View.INVISIBLE
}

fun View.gone() {
    visibility = View.GONE
}


fun View.animHide() {
    animGone(1)
}

fun AppCompatTextView.showIfNotNull(txt: String?) {
    if (txt.isNullOrEmpty())
        gone()
    else {
        text = txt
        show()
    }
}

fun View.showIfNotNull(txt: String?) {
    if (txt.isNullOrEmpty())
        gone()
    else
        show()
}

fun Toolbar.enableScroll() {
    val params = layoutParams as AppBarLayout.LayoutParams
    params.apply {
        scrollFlags =
            AppBarLayout.LayoutParams.SCROLL_FLAG_SCROLL or AppBarLayout.LayoutParams.SCROLL_FLAG_ENTER_ALWAYS
    }
}

fun Toolbar.disabledScroll() {
    val params = layoutParams as AppBarLayout.LayoutParams
    params.scrollFlags = 0
}

fun View.animGone(type: Int = 0) {

    if (visibility != View.VISIBLE)
        return

    animate().alpha(0f).setDuration(300).setListener(object : AnimatorListenerAdapter() {
        override fun onAnimationEnd(animation: Animator) {
            super.onAnimationEnd(animation)
            visibility = View.GONE
        }
    })
}


fun NestedScrollView.scrollToBottomNow(toView: View?) {
    toView?.let {
        postDelayed({
            scrollTo(0, it.bottom)
        }, 100)
    }
}

fun NestedScrollView.scrollToBottom(toView: View) {
    postDelayed({
        scrollTo(0, toView.bottom)
    }, 500)
}

fun NestedScrollView.scrollToTop(toView: View) {
    postDelayed({
        scrollTo(0, toView.bottom)
    }, 500)
}


fun Array<ViewGroup>.showAnimAll() {
    this.forEach {
        it.animShow()
    }
}

fun Array<ViewGroup>.goneAnimAll() {
    this.forEach {
        it.animGone()
    }
}

fun Array<View>.showAll() {
    this.forEach {
        it.show()
    }
}

fun Array<View>.goneAll() {
    this.forEach {
        it.gone()
    }
}


fun View.isVisible() = visibility == View.VISIBLE

fun View.animShow() {

    if (visibility == View.VISIBLE)
        return

    animate().alpha(1f).setDuration(300).setListener(object : AnimatorListenerAdapter() {
        override fun onAnimationStart(animation: Animator) {
            super.onAnimationStart(animation)
            visibility = View.VISIBLE
        }
    })
}

// slide the view from below itself to the current position
fun View.slideUp() {
    visibility = View.VISIBLE
    val animate = TranslateAnimation(
        0F,  // fromXDelta
        0F,  // toXDelta
        height.toFloat(),  // fromYDelta
        0F
    ) // toYDelta
    animate.duration = 300
    animate.fillAfter = true
    startAnimation(animate)
}

// slide the view from its current position to below itself
fun slideDown(view: View) {
    val animate = TranslateAnimation(
        0F,  // fromXDelta
        0F,  // toXDelta
        0F,  // fromYDelta
        view.height.toFloat()
    ) // toYDelta
    animate.duration = 500
    animate.fillAfter = true
    view.startAnimation(animate)
}

fun ViewGroup.getInflatedLayout(layoutToInflate: Int): View =
    LayoutInflater.from(context).inflate(layoutToInflate, this, false)

fun AppCompatImageView.rotateClockWise() {
    val anim = ObjectAnimator.ofFloat(this, "rotation", 180f, 0f)
    anim.duration = 500
    anim.start()
}

fun AppCompatImageView.rotateAntiClockWise() {
    val anim = ObjectAnimator.ofFloat(this, "rotation", 0f, 180f)
    anim.duration = 500
    anim.start()
}

fun View?.findSuitableParent(): ViewGroup? {
    var view = this
    var fallback: ViewGroup? = null
    do {
        if (view is CoordinatorLayout) {
            // We've found a CoordinatorLayout, use it
            return view
        } else if (view is FrameLayout) {
            if (view.id == android.R.id.content) {
                // If we've hit the decor content view, then we didn't find a CoL in the
                // hierarchy, so use it.
                return view
            } else {
                // It's not the content view but we'll use it as our fallback
                fallback = view
            }
        }

        if (view != null) {
            // Else, we will loop and crawl up the view hierarchy and try to find a parent
            val parent = view.parent
            view = if (parent is View) parent else null
        }
    } while (view != null)

    // If we reach here then we didn't find a CoL or a suitable content view so we'll fallback
    return fallback
}

fun RecyclerView.verticalView(context: Context) {
    layoutManager = LinearLayoutManager(context)
}

fun RecyclerView.horizontalView(context: Context) {
    layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
}

fun RecyclerView.gridView(context: Context, spanCount: Int) {
    layoutManager = GridLayoutManager(context, spanCount)
}

fun AppCompatImageView.setUnlocked() {
    colorFilter = null
    imageAlpha = 255
}

inline fun <T : Any> guardLet(vararg elements: T?, closure: () -> Nothing): List<T> {
    return if (elements.all { it != null }) {
        elements.filterNotNull()
    } else {
        closure()
    }
}

inline fun <T : Any> ifLet(vararg elements: T?, closure: (List<T>) -> Unit) {
    if (elements.all { it != null }) {
        closure(elements.filterNotNull())
    }
}


fun View.setMargins(left: Int? = null, top: Int? = null, right: Int? = null, bottom: Int? = null) {
    val lp = layoutParams as? ViewGroup.MarginLayoutParams ?: return
    lp.setMargins(
        left ?: lp.leftMargin,
        top ?: lp.topMargin,
        right ?: lp.rightMargin,
        bottom ?: lp.rightMargin
    )
    this.layoutParams = lp
}

fun BottomNavigationView.uncheckAllItems() {
    menu.setGroupCheckable(0, true, false)
    for (i in 0 until menu.size()) {
        menu.getItem(i).isChecked = false
    }
    menu.setGroupCheckable(0, true, true)
}


enum class TYPE {
    SUCCESS, FAILURE, VALIDATION, NONE
}

fun Float.toDp(displayMetrics: DisplayMetrics) =
    TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, this, displayMetrics)


fun Context.dp(px: Number): Float {
    val resources = this.resources
    val metrics = resources.displayMetrics
    return (px.toFloat() /
            (metrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT.toFloat()))
}

fun Context.px(dp: Number): Float {
    val resources = this.resources
    val metrics = resources.displayMetrics
    return (dp.toFloat() *
            (metrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT.toFloat()))
}


fun Context.getBsDrawable(res: Int): Drawable? {
    return ContextCompat.getDrawable(this, res)
}

fun Context.getBsColor(res: Int): Int {
    return ContextCompat.getColor(this, res)
}

fun Context.getBsFont(res: Int): Typeface {
    return ResourcesCompat.getFont(this, res)!!
}

fun Context.showToast(text: String) {
    Toast.makeText(this, text, Toast.LENGTH_LONG).show()
}


fun TabLayout.setTabBG(tabStartRes: Int, tabCenterRes: Int, tabEndRes: Int) {
    val tabStrip = getChildAt(0) as ViewGroup

    tabStrip.getChildAt(0)?.let {
        val paddingStart = it.paddingStart
        val paddingTop = it.paddingTop
        val paddingEnd = it.paddingEnd
        val paddingBottom = it.paddingBottom
        ViewCompat.setBackground(
            it,
            AppCompatResources.getDrawable(it.context, tabStartRes)
        )
        ViewCompat.setPaddingRelative(
            it,
            paddingStart,
            paddingTop,
            paddingEnd,
            paddingBottom
        )
    }
    tabStrip.getChildAt(1)?.let {

        val paddingStart = it.paddingStart
        val paddingTop = it.paddingTop
        val paddingEnd = it.paddingEnd
        val paddingBottom = it.paddingBottom
        ViewCompat.setBackground(
            it,
            AppCompatResources.getDrawable(it.context, tabCenterRes)
        )
        ViewCompat.setPaddingRelative(
            it,
            paddingStart,
            paddingTop,
            paddingEnd,
            paddingBottom
        )
    }
    tabStrip.getChildAt(2).let {
        val paddingStart = it.paddingStart
        val paddingTop = it.paddingTop
        val paddingEnd = it.paddingEnd
        val paddingBottom = it.paddingBottom
        ViewCompat.setBackground(
            it,
            AppCompatResources.getDrawable(it.context, tabEndRes)
        )
        ViewCompat.setPaddingRelative(
            it,
            paddingStart,
            paddingTop,
            paddingEnd,
            paddingBottom
        )
    }
}

fun EditText.showKeyboard2() {
    if (requestFocus()) {
        (getActivity()?.getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager)
            .showSoftInput(this, SHOW_IMPLICIT)
        setSelection(text.length)
    }
}


fun View.getActivity(): AppCompatActivity? {
    var context = this.context
    while (context is ContextWrapper) {
        if (context is AppCompatActivity) {
            return context
        }
        context = context.baseContext
    }
    return null
}

fun ViewGroup.restoreChildViewStates(childViewStates: SparseArray<Parcelable>) {
    children.forEach { child -> child.restoreHierarchyState(childViewStates) }
}

fun ViewGroup.saveChildViewStates(): SparseArray<Parcelable> {
    val childViewStates = SparseArray<Parcelable>()
    children.forEach { child -> child.saveHierarchyState(childViewStates) }
    return childViewStates
}


val LIST_CHAT: HashMap<String, Int> = HashMap()


fun getGoto(goto: String): Int? = LIST_CHAT[goto]
