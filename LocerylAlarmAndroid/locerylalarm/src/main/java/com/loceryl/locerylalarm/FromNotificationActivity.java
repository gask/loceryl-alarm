package com.loceryl.locerylalarm;

import android.app.AlarmManager;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.Menu;
import android.view.MenuItem;

public class FromNotificationActivity extends FragmentActivity {

    private static Intent intent;
    public static Intent getStaticIntent(Context context) {
        if (intent == null) {
            intent = new Intent(context, FromNotificationActivity.class);
        }
        return intent;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        AlarmManager alarmManager = (AlarmManager)getSystemService(ALARM_SERVICE);
        alarmManager.cancel(NotificationService.getStaticPendingIntent(this));
        NotificationManager notificationManager = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        notificationManager.cancelAll();

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
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
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
