package com.loceryl.locerylalarm;

import android.widget.DatePicker;

import java.util.Calendar;

/**
 * Created by szzaass on 02/02/14.
 */
public class CustomDate {
    public static String stringFromDatePicker(DatePicker picker) {
        return String.format(Constants.DATE_FORMAT, picker.getDayOfMonth(), picker.getMonth()+1, picker.getYear());
    }

    public static String stringFromCalendar(Calendar calendar) {
        return String.format(Constants.DATE_FORMAT, calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.MONTH), calendar.get(Calendar.YEAR));
    }

    public static Calendar calendarFromDatePicker(DatePicker picker) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, picker.getMonth()+1);
        calendar.set(Calendar.DAY_OF_MONTH, picker.getDayOfMonth());
        calendar.set(Calendar.YEAR, picker.getYear());
        return calendar;
    }

}
