package com.loceryl.locerylalarm;

import android.app.AlarmManager;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

import java.util.Calendar;

public final class Helper {

    public static void goToView(Context context, Class clazz) {
        Intent intent = new Intent(context, clazz);
        context.startActivity(intent);
    }

    public static void saveDate(Context context, Calendar calendar) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        if (calendar == null) {
            preferences.edit().putLong(Constants.DATE, 0).commit();
        }
        else {
            preferences.edit().putLong(Constants.DATE, calendar.getTimeInMillis()).commit();
        }
    }

    public static Calendar loadDate(Context context) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        long date = preferences.getLong(Constants.DATE, 0);
        if (date == 0) {
            return Calendar.getInstance();
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(date);
        return calendar;
    }

    public static void createAlarm(Context context, Calendar date) {
        Intent intent = new Intent (context, NotificationService.class);
        PendingIntent pendingIntent = PendingIntent.getService(context, Constants.NOTIFICATION_SERVICE_ID, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        AlarmManager alarmManager = (AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, date.getTimeInMillis(), Constants.REPEAT_DELAY, pendingIntent);
        setAlarmSet(context, true);
    }

    public static void cancelAlarm(Context context) {
        Intent intent = new Intent (context, NotificationService.class);
        PendingIntent pendingIntent = PendingIntent.getService(context, Constants.NOTIFICATION_SERVICE_ID, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        AlarmManager alarmManager = (AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.cancel(pendingIntent);
        setAlarmSet(context, false);
    }

    public static boolean isAlarmSet(Context context) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        return preferences.getBoolean(Constants.ALARM_SET, false);
    }

    public static void setAlarmSet(Context context, boolean isSet) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        preferences.edit().putBoolean(Constants.ALARM_SET, isSet).commit();
    }

    public static void clearNotifications(Context context) {
        NotificationManager notificationManager = (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

}
