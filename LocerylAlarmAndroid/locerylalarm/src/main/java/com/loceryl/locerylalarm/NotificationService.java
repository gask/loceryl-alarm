package com.loceryl.locerylalarm;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.os.IBinder;
import android.support.v4.app.NotificationCompat;
import android.support.v4.app.TaskStackBuilder;
import android.widget.Toast;

import java.util.Calendar;

/**
 * Created by szzaass on 02/02/14.
 */
public class NotificationService extends Service {

//    private static Intent intent;
//    public static Intent intent(Context context) {
//        if (intent == null) {
//            intent = new Intent(context, NotificationService.class);
//        }
//        return intent;
//    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
//        Toast.makeText(this, "onCreate()", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
//        Toast.makeText(this, "onDestroy()", Toast.LENGTH_SHORT).show();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
//        Toast.makeText(this, "onStartCommand()", Toast.LENGTH_SHORT).show();
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onStart(Intent intent, int startId) {
        super.onStart(intent, startId);

        Intent notificationIntent = new Intent(this, FromNotificationActivity.class);
        TaskStackBuilder stackBuilder = TaskStackBuilder.create(this);
        stackBuilder.addParentStack(FromNotificationActivity.class);
        stackBuilder.addNextIntent(notificationIntent);

        PendingIntent pendingIntent = stackBuilder.getPendingIntent(Constants.FROM_NOTIF_ACTIVITY_ID, PendingIntent.FLAG_UPDATE_CURRENT);
        int icon = R.drawable.ic_launcher;
        long when = Calendar.getInstance().getTimeInMillis();
        String alarmPath = String.format("%s://%s/%s", ContentResolver.SCHEME_ANDROID_RESOURCE, getPackageName(), R.raw.locerylsound);
        Uri alarmSound = Uri.parse(alarmPath);
        Notification notification = new NotificationCompat.Builder(this)
                .setSound(alarmSound)
                .setContentTitle(Constants.NOTIFICATION_TITLE)
                .setContentText(Constants.NOTIFICATION_MESSAGE)
                .setSmallIcon(icon)
                .setWhen(when)
                .setContentIntent(pendingIntent)
                .setDefaults(Notification.DEFAULT_LIGHTS | Notification.DEFAULT_VIBRATE)
                .setAutoCancel(true)
                .build();

        NotificationManager notificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        notificationManager.notify(0, notification);
        Toast.makeText(this, Constants.NOTIFICATION_MESSAGE, Toast.LENGTH_LONG).show();
    }

}
