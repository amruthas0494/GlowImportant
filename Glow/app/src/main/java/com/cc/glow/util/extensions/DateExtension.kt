package com.cc.glow.util.extensions

import android.util.Log
import java.text.SimpleDateFormat
import java.util.*


const val SERVER_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
const val SERVER_DATE_FORMAT2 = "yyyy-MM-dd'T'HH:mm:ss"
const val APP_DATE_FORMAT = "MM/dd/yyyy"
const val APP_TIME_FORMAT = "hh:mm a"

fun String?.getDateInMilliSecond(): Long {
    this?.let { dateStr ->
        //2020-06-10T09:05:41.672Z
        val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
        val date = sdf.parse(dateStr)
        date?.let {
            val mCalendar = Calendar.getInstance()
            mCalendar.time = it
            mCalendar.add(Calendar.HOUR, 5)
            mCalendar.add(Calendar.MINUTE, 30)
            return mCalendar.timeInMillis
        }
    }
    return System.currentTimeMillis()
}

fun Long.getPrettyTime(): String {
    /*return when (val mDate = PrettyTime(Locale.getDefault()).format(Date(this))) {
        "moments from now", "moments ago" -> "just now"
        else -> mDate
    }*/
    return "PrettyTime not configured!"
}

fun String.isTodayDate(): Boolean {
    val sdf = SimpleDateFormat(APP_DATE_FORMAT, Locale.getDefault())
    val convertedDate = convertDateFormat(this, SERVER_DATE_FORMAT, APP_DATE_FORMAT)
    val strDate = sdf.parse(convertedDate) ?: return false
    val todaySdf = SimpleDateFormat(APP_DATE_FORMAT, Locale.getDefault())
    val strTodayDate = todaySdf.parse(getTodayDate(APP_DATE_FORMAT))!!
    return strTodayDate.time == strDate.time
}

fun String?.getDateWithTimeStamp(): String {

    if (this == null) {
        return ""
    }

    this.let { dateStr ->
        //2020-06-10T09:05:41.672Z
        val rawDateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
        val targetFormat = SimpleDateFormat("MMMM dd 'at' hh:mm aa", Locale.getDefault())
        var rawDate: Date? = null
        try {
            rawDate = rawDateFormat.parse(dateStr)
        } catch (ex: Exception) {
            return dateStr
        }
        rawDate?.let {
            val modifiedDate = Calendar.getInstance().apply {
                time = it
                add(Calendar.HOUR, 5)
                add(Calendar.MINUTE, 30)
            }.time
            return targetFormat.format(modifiedDate)
        }
    }
    return this.getDateInMilliSecond().getPrettyTime()
}


/*
 type :
 1 => add; 0 => subtract
 */
fun getNewDate(currentDate: String, amount: Int): String {
    val sdf = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
    sdf.parse(currentDate)?.let {
        val calendar = Calendar.getInstance()
        calendar.time = it
        calendar.add(Calendar.DATE, amount)
        return sdf.format(calendar.time)
    }
    return currentDate
}

fun getChatTimeStamp(): String? {

    val chatDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    val dateStr = getTodayDate(chatDateFormat)

    //2020-06-10T09:05:41.672Z
    val rawDateFormat = SimpleDateFormat(chatDateFormat, Locale.getDefault())
    val targetFormat = SimpleDateFormat(chatDateFormat, Locale.getDefault())
    var rawDate: Date? = null
    try {
        rawDate = rawDateFormat.parse(dateStr)
    } catch (ex: Exception) {
        return dateStr
    }
    rawDate?.let {
        val modifiedDate = Calendar.getInstance().apply {
            time = it
            add(Calendar.HOUR, -5)
            add(Calendar.MINUTE, -30)
        }.time

        Log.d("DateX", "getChatTimeStamp: modifiedDate $modifiedDate")

        return targetFormat.format(modifiedDate)
    }
    return null
}


fun getTodayDate(format: String = "yyyy-MM-dd"): String {
    val sdf = SimpleDateFormat(format, Locale.getDefault())
    return sdf.format(Date())
}

fun addDaysToCurrentDate(daysToAdd: Int, format: String = "yyyy-MM-dd"): String {
    val sdf = SimpleDateFormat(format, Locale.getDefault())
    val currentDate = sdf.format(Date())
    val calendar = Calendar.getInstance()
    calendar.time = sdf.parse(currentDate) ?: Date()
    calendar.add(Calendar.DATE, daysToAdd)
    return sdf.format(calendar.time)
}

fun getTodayDateWithUTC(format: String = "yyyy-MM-dd"): String {
    val sdf2 = SimpleDateFormat(format, Locale.getDefault())
    sdf2.timeZone = TimeZone.getTimeZone("UTC")
    return sdf2.format(Date())
}

fun getTodayDay(format: String = "EEEE"): String {
    val sdf = SimpleDateFormat(format, Locale.getDefault())
    return sdf.format(Date())
}

fun handleDateByCreatedOrMod(createdAt: String?, updatedAt: String?) {

}


fun convertDateFormat(rawDate: String?, dateFormat: String, targetFormatToConvert: String): String {
    if (rawDate == null) {
        return ""
    }
    val sdf = SimpleDateFormat(dateFormat, Locale.getDefault())
    sdf.timeZone = TimeZone.getTimeZone("UTC")
    val date = sdf.parse(rawDate)
    val targetFormat = SimpleDateFormat(targetFormatToConvert, Locale.getDefault())
    targetFormat.timeZone = TimeZone.getDefault()
    var convertedDate = targetFormat.format(date!!)

    if (targetFormatToConvert == APP_TIME_FORMAT && convertedDate[0].toString() == "0")
        convertedDate = convertedDate.substring(1)

    return convertedDate
}

private fun parseDayWithMonth(rawDate: String, targetFormatToConvert: String): String {
    val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
    val date = sdf.parse(rawDate)
    val targetFormat = SimpleDateFormat(targetFormatToConvert, Locale.getDefault())
    return targetFormat.format(date!!)
}

private fun parseDayWithMonth(rawDate: String): String {
    val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
    val date = sdf.parse(rawDate)
    val targetFormat = SimpleDateFormat("MMMM dd 'at' hh:mm aa", Locale.getDefault())
    return targetFormat.format(date!!)
}

private fun parseTime(rawDate: String): String {

    val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.getDefault())
    val date = sdf.parse(rawDate)
    val targetFormat = SimpleDateFormat("hh:mm aa", Locale.getDefault())
    return targetFormat.format(date!!)
}