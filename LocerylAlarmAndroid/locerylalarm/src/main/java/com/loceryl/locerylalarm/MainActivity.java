package com.loceryl.locerylalarm;

import android.app.AlarmManager;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.DatePicker;
import android.widget.TextView;

import java.util.Calendar;

public class MainActivity extends FragmentActivity {

    private PickerFragment picker;
    private Calendar date;

    private static Intent intent;
    public static Intent getStaticIntent(Context context) {
        if (intent == null) {
            intent = new Intent(context, MainActivity.class);
        }
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.main);
        AlarmManager alarmManager = (AlarmManager)getSystemService(ALARM_SERVICE);
        alarmManager.cancel(NotificationService.getStaticPendingIntent(this));
        if (loadDate()) {
            startAlarm(null);
        }
        NotificationManager notificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        notificationManager.cancelAll();

        picker = new PickerFragment();
        intent = getIntent();
        TextView dateText = (TextView)findViewById(R.id.main_date);
        dateText.setText(CustomDate.stringFromCalendar(Calendar.getInstance()));

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.main_layout, picker)
                    .hide(picker)
                    .commit();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
    public void showPicker(View view) {
        getSupportFragmentManager().beginTransaction()
                .show(picker)
                .commit();
    }

    public void hidePicker() {
        getSupportFragmentManager().beginTransaction()
                .hide(picker)
                .commit();
    }

    public void startAlarm(View view) {
        if (date == null) {
            date = Calendar.getInstance();
        }
        date.add(Calendar.DAY_OF_MONTH, Constants.ALARM_TIME);
        saveDate();
        long repeat = Constants.REPEAT_DELAY;
        AlarmManager alarmManager = (AlarmManager)getSystemService(ALARM_SERVICE);
//        alarmManager.cancel(NotificationService.getStaticPendingIntent(this));
        alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, date.getTimeInMillis(), repeat, NotificationService.getStaticPendingIntent(this));
    }

    public void pickerButtonClick(View view) {
        DatePicker datePicker = (DatePicker) findViewById(R.id.fdatepicker_picker);
        date = CustomDate.calendarFromDatePicker(datePicker);
        hidePicker();
        TextView dateText = (TextView)findViewById(R.id.main_date);
        dateText.setText(CustomDate.stringFromCalendar(date));
        updateLayout();
    }

    private void saveDate() {
        SharedPreferences preferences = getSharedPreferences(Constants.SETTINGS, MODE_PRIVATE);
        preferences.edit().putLong(Constants.DATE, date.getTimeInMillis()).commit();
    }

    private boolean loadDate() {
        SharedPreferences preferences = getSharedPreferences(Constants.SETTINGS, MODE_PRIVATE);
        long millis = preferences.getLong(Constants.DATE, 0);
        if (millis == 0) {
            return false;
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(millis);
        date = calendar;
        return true;
    }
    @Override
    public void onBackPressed() {
        if (picker.isVisible()) {
            hidePicker();
        }
        else {
            super.onBackPressed();
        }
    }

    private void updateLayout() {
        ViewGroup layout = (ViewGroup)findViewById(R.id.main_layout);
        layout.invalidate();
    }
}
