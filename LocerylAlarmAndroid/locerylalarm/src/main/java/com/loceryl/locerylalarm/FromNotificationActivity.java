package com.loceryl.locerylalarm;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.Window;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import java.util.Calendar;

public class FromNotificationActivity extends FragmentActivity {

//    private static Intent intent;
//    public static Intent getStaticIntent(Context context) {
//        if (intent == null) {
//            intent = new Intent(context, FromNotificationActivity.class);
//        }
//        return intent;
//    }

    private Spinner spinner;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.from_notif);

        spinner = (Spinner) findViewById(R.id.from_notif_spinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this, R.array.delay_array, android.R.layout.simple_spinner_dropdown_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Helper.clearNotifications(this);
    }

    @Override
    public void onBackPressed() {
        snoozerButtonClicked(null);
    }

    public void snoozerButtonClicked(View view) {
        Helper.cancelAlarm(this);
        Helper.clearNotifications(this);

        int delay = spinner.getSelectedItemPosition();
        Calendar date = Calendar.getInstance();
        date.add(Calendar.MILLISECOND, Constants.DELAYS[delay]);
        Helper.saveDate(this, date);

        Intent intent = new Intent(this, NotificationService.class);
        PendingIntent pendingIntent = PendingIntent.getService(this, Constants.NOTIFICATION_SERVICE_ID, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        AlarmManager alarmManager = (AlarmManager)getSystemService(ALARM_SERVICE);
        alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, date.getTimeInMillis(), Constants.REPEAT_DELAY, pendingIntent);
        Helper.setAlarmSet(this, true);

        intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }
}
