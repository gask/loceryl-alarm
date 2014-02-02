package com.loceryl.locerylalarm;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.IBinder;
import android.widget.Toast;

import java.util.Calendar;

/**
 * Created by szzaass on 02/02/14.
 */
public class NotificationService extends Service {

    private static Intent intent;
    public static Intent getStaticIntent(Context context) {
        if (intent == null) {
            intent = new Intent(context, NotificationService.class);
        }
        return intent;
    }
    public static PendingIntent getStaticPendingIntent(Context context) {
        return PendingIntent.getService(context, 0, getStaticIntent(context), PendingIntent.FLAG_UPDATE_CURRENT);
    }


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
        NotificationManager notificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        Intent notificationIntent = MainActivity.getStaticIntent(this);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        int icon = R.drawable.ic_launcher;
        String ticker = "Time for Loceryl!";
        String title = "Loceryl Alarm";
        String message = "You should take your medicine right now!";
        long when = Calendar.getInstance().getTimeInMillis();
        String alarmPath = String.format("%s://%s/%s", ContentResolver.SCHEME_ANDROID_RESOURCE, getPackageName(), R.raw.locerylsound);
        Uri alarmSound = Uri.parse(alarmPath);
        Notification notification = new Notification.Builder(this)
                .setSound(alarmSound)
//                .setTicker(ticker)
                .setContentTitle(title)
                .setContentText(message)
                .setSmallIcon(icon)
                .setWhen(when)
                .setContentIntent(pendingIntent)
                .setDefaults(Notification.DEFAULT_LIGHTS | Notification.DEFAULT_VIBRATE)
                .build();

        notificationManager.notify(123, notification);
        Toast.makeText(this, ticker, Toast.LENGTH_LONG).show();
    }
}
