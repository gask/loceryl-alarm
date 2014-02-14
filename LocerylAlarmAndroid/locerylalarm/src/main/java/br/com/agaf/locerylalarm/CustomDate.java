package br.com.agaf.locerylalarm;

import android.widget.DatePicker;

import java.util.Calendar;

public class CustomDate {

    public static String stringFromCalendar(Calendar calendar) {
        return String.format(Constants.DATE_FORMAT, calendar.get(Calendar.DAY_OF_MONTH), calendar.get(Calendar.MONTH)+1, calendar.get(Calendar.YEAR));
    }

    public static Calendar calendarFromDatePicker(DatePicker picker) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, picker.getMonth());
        calendar.set(Calendar.DAY_OF_MONTH, picker.getDayOfMonth());
        calendar.set(Calendar.YEAR, picker.getYear());
        return calendar;
    }

    public static String timeFromCalendar(Calendar calendar) {
        return String.format(Constants.HOUR_FORMAT, calendar.get(Calendar.HOUR_OF_DAY), calendar.get(Calendar.MINUTE));
    }

}
