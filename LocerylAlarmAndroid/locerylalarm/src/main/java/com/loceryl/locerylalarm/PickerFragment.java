package com.loceryl.locerylalarm;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * Created by szzaass on 01/02/14.
 */
public class PickerFragment extends Fragment {

    public PickerFragment() {
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.f_date_picker, container, false);
        return rootView;
    }
}
