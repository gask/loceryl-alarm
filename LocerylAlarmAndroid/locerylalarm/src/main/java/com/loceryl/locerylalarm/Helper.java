package com.loceryl.locerylalarm;

import android.app.ActivityManager;
import android.app.AlarmManager;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

import java.util.Calendar;
import java.util.List;

/**
 * Created by szzaass on 02/02/14.
 */
public final class Helper {
    public static boolean isRunning(Context context, Class clazz) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        List<ActivityManager.RunningTaskInfo> tasks = activityManager.getRunningTasks(Integer.MAX_VALUE);

        for (ActivityManager.RunningTaskInfo task : tasks) {
            if (clazz.getPackage().getName().equalsIgnoreCase(task.baseActivity.getPackageName()))
                return true;
        }

        return false;
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

    public static void cancelAlarm(Context context) {
        Intent intent = new Intent (context, NotificationService.class);
        PendingIntent pendingIntent = PendingIntent.getService(context, Constants.NOTIFICATION_SERVICE_ID, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        AlarmManager alarmManager = (AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.cancel(pendingIntent);
    }

    public static void clearNotifications(Context context) {
        NotificationManager notificationManager = (NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

    public static boolean isAlarmSet(Context context) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        return preferences.getBoolean(Constants.ALARM_SET, false);
    }

    public static void setAlarmSet(Context context, boolean isSet) {
        SharedPreferences preferences = context.getSharedPreferences(Constants.SETTINGS, Context.MODE_PRIVATE);
        preferences.edit().putBoolean(Constants.ALARM_SET, isSet).commit();
    }

}
