package br.com.agaf.locerylalarm;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.Window;

public class WorksActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.works);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    public void backToMain(View view) {
        onBackPressed();
        finish();
    }

}
