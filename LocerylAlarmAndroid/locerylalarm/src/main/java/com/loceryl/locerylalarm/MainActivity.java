package com.loceryl.locerylalarm;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.DatePicker;
import android.widget.TextView;

import java.util.Calendar;

public class MainActivity extends FragmentActivity {

    private PickerFragment picker;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.main);


        picker = new PickerFragment();

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.main_layout, picker)
                    .hide(picker)
                    .commit();
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        Helper.clearNotifications(this);
        toggleTerminateVisual(Helper.isAlarmSet(this));
    }

    @Override
    public void onBackPressed() {
        if (picker.isVisible()) {
            hideFragment(picker);
        }
        else {
            super.onBackPressed();
        }
    }

    public void showPicker(View view) {
        showFragment(picker);
    }

    public void showFragment(Fragment fragment) {
        getSupportFragmentManager().beginTransaction()
                .show(fragment)
                .commit();
    }

    public void hideFragment(Fragment fragment) {
        getSupportFragmentManager().beginTransaction()
                .hide(fragment)
                .commit();
    }

    public void showView(View view) {
        view.setEnabled(true);
        view.setVisibility(View.VISIBLE);
    }

    public void hideView(View view) {
        view.setEnabled(false);
        view.setVisibility(View.INVISIBLE);
    }

    public void setViewText(int viewId, String description) {
        TextView view = (TextView)findViewById(viewId);
        view.setText(description);
    }

    public void toggleTerminateVisual(boolean terminateShown) {
        if (terminateShown) {
            Calendar date = Helper.loadDate(this);
            String description = getResources().getString(R.string.description_set, CustomDate.stringFromCalendar(date), CustomDate.timeFromCalendar(date));
            setViewText(R.id.main_description, description);
            hideView(findViewById(R.id.main_date));
            hideView(findViewById(R.id.main_btok));
            showView(findViewById(R.id.main_btterminate));
        }
        else {
            setViewText(R.id.main_date, CustomDate.stringFromCalendar(Calendar.getInstance()));
            String description = getResources().getString(R.string.description_unset);
            setViewText(R.id.main_description, description);
            showView(findViewById(R.id.main_date));
            showView(findViewById(R.id.main_btok));
            hideView(findViewById(R.id.main_btterminate));
        }
        updateLayout();
    }

    public void startAlarm(View view) {
        DatePicker datePicker = (DatePicker) findViewById(R.id.fdatepicker_picker);
        Calendar date = CustomDate.calendarFromDatePicker(datePicker);
        date.add(Calendar.DAY_OF_MONTH, Constants.ALARM_TIME);

        Helper.saveDate(this, date);
        Helper.createAlarm(this, date);
        toggleTerminateVisual(true);
    }

    public void terminateAlarm(View view) {
        Helper.saveDate(this, null);
        Helper.cancelAlarm(this);
        Helper.clearNotifications(this);
        toggleTerminateVisual(false);
    }

    public void pickerButtonClick(View view) {
        DatePicker datePicker = (DatePicker) findViewById(R.id.fdatepicker_picker);
        Calendar date = CustomDate.calendarFromDatePicker(datePicker);
        hideFragment(picker);
        setViewText(R.id.main_date, CustomDate.stringFromCalendar(date));
        updateLayout();
    }

    public void showHowItWorks(View view) {
        Intent intent = new Intent(this, WorksActivity.class);
        startActivity(intent);
    }

    private void updateLayout() {
        ViewGroup layout = (ViewGroup)findViewById(R.id.main_layout);
        layout.invalidate();
    }
}