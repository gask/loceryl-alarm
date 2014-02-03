package com.loceryl.locerylalarm;

/**
 * Created by szzaass on 02/02/14.
 */
public final class Constants {

    public static final String NOTIFICATION_TITLE = "Alarme do Loceryl";
    public static final String NOTIFICATION_MESSAGE = "Hora de aplicar o Loceryl esmalte!";
    public static final int ALARM_TIME = 7;
    public static final long REPEAT_DELAY = (1000*60*60*24) * ALARM_TIME;
    public static final String SETTINGS = "settings";
    public static final String ALARM_SET = "alarmSet";
    public static final String DATE = "date";
    public static final String DATE_FORMAT = "%02d/%02d/%d";
    public static final String HOUR_FORMAT = "%02d:%02d";
    public static final int DELAYS[] = {0, 1000*60*30, 1000*60*60, 1000*60*60*4};

    public static final int NOTIFICATION_SERVICE_ID = 123456;
    public static final int FROM_NOTIF_ACTIVITY_ID = 445566;

}
