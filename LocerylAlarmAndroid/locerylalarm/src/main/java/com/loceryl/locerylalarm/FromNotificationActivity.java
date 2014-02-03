package com.loceryl.locerylalarm;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.Window;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import java.util.Calendar;

public class FromNotificationActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.from_notif);

        Spinner spinner = (Spinner) findViewById(R.id.from_notif_spinner);
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

        Spinner spinner = (Spinner) findViewById(R.id.from_notif_spinner);
        int delay = spinner.getSelectedItemPosition();
        Calendar date = Calendar.getInstance();
        date.add(Calendar.MILLISECOND, Constants.DELAYS[delay]);

        Helper.saveDate(this, date);
        Helper.createAlarm(this, date);

        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }
}
