using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class SBRView extends WatchUi.WatchFace {

	var swWatch = System.getDeviceSettings().screenWidth;
    var shWatch = System.getDeviceSettings().screenHeight;
    
    var is920xt = (swWatch == 205 && shWatch == 148);
    var isFenix5 = (swWatch == 240 && shWatch == 240);
    var isFenix5S = (swWatch == 218 && shWatch == 218);
    var isFr230 = (swWatch == 215 && shWatch == 180);
    
	var swim = "";
	var bike = "";
	var run = "";
	var day = "";
	var percentBattery = "";
	
    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
    	if (isFenix5 || isFenix5S || isFr230) {
    		setLayout(Rez.Layouts.LayoutSBR(dc));
    	}   
    }

    function onShow() {
            
    	// Fonts and colors
    	var fontSBR      = Graphics.FONT_MEDIUM;
    	var fontSmallSBR = Graphics.FONT_SYSTEM_SMALL;
    	var fontDayPB    = Graphics.FONT_SMALL;
    	var colorSwim    = Graphics.COLOR_BLUE;
    	var colorBike    = Graphics.COLOR_GREEN;
    	var colorRun     = Graphics.COLOR_RED;
    	var colorDay     = Graphics.COLOR_WHITE;
    	var colorPB      = Graphics.COLOR_WHITE;
    	
    	if (is920xt) {
    		// Swim
	    	swim = new WatchUi.Text({
	            :text  => "SWIM",
	            :color => colorSwim,
	            :font  => fontSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_LEFT,
	            :locY  => WatchUi.LAYOUT_VALIGN_BOTTOM
	        });
            // Bike
	        bike = new WatchUi.Text({
	            :text  => "BIKE",
	            :color => colorBike,
	            :font  => fontSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_CENTER,
	            :locY  => WatchUi.LAYOUT_VALIGN_BOTTOM
	        });
	        // Run
	        run = new WatchUi.Text({
	            :text  => "RUN",
	            :color => colorRun,
	            :font  => fontSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_RIGHT,
	            :locY  => WatchUi.LAYOUT_VALIGN_BOTTOM
	        });
	        // Day
	        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
			var dateString = Lang.format("$1$ $2$ $3$ $4$", [ today.day_of_week, today.day, today.month, today.year ]);
			day = new WatchUi.Text({
	            :text  => dateString,
	            :color => colorDay,
	            :font  => fontDayPB,
	            :locX  => WatchUi.LAYOUT_HALIGN_CENTER,
	            :locY  => WatchUi.LAYOUT_VALIGN_TOP
	        });
	        // Percent battery
	        var systemStats = System.getSystemStats();
	        var battery = System.getSystemStats().battery;
	        var batteryDisplay = battery.format("%02d");
			percentBattery = new WatchUi.Text({
	            :text  => batteryDisplay + "%",
	            :color => colorPB,
	            :font  => fontDayPB,
	            :locX  => WatchUi.LAYOUT_HALIGN_RIGHT,
	            :locY  => WatchUi.LAYOUT_VALIGN_TOP
	        });
    	} else if (isFenix5 || isFenix5S) {
    		// Swim
	    	swim = new WatchUi.Text({
	            :text  => "SWIM",
	            :color => colorSwim,
	            :font  => fontSmallSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_LEFT,
	            :locY  => WatchUi.LAYOUT_VALIGN_CENTER
	        });
            // Bike
	        bike = new WatchUi.Text({
	            :text  => "BIKE",
	            :color => colorBike,
	            :font  => fontSmallSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_RIGHT,
	            :locY  => WatchUi.LAYOUT_VALIGN_CENTER
	        });
    	} else if (isFr230) {
    		// Swim
	    	swim = new WatchUi.Text({
	            :text  => "SWIM",
	            :color => colorSwim,
	            :font  => fontSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_LEFT,
	            :locY  => WatchUi.LAYOUT_VALIGN_CENTER
	        });
            // Bike
	        bike = new WatchUi.Text({
	            :text  => "BIKE",
	            :color => colorBike,
	            :font  => fontSBR,
	            :locX  => WatchUi.LAYOUT_HALIGN_RIGHT,
	            :locY  => WatchUi.LAYOUT_VALIGN_CENTER
	        });
    	}
    }

    function onUpdate(dc) {
    
    	if (isFenix5 || isFenix5S || isFr230) {
    		// Day
	        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
			var dateString = Lang.format("$1$ $2$ $3$ $4$", [ today.day_of_week, today.day, today.month, today.year ]);
	    	var dayLabel = View.findDrawableById("DayLabel");
	        dayLabel.setText(dateString);
	        dayLabel.setLocation(WatchUi.LAYOUT_HALIGN_CENTER, 50);
	        if (isFr230) {
	        	dayLabel.setLocation(WatchUi.LAYOUT_HALIGN_CENTER, 37);
	        }
	        // Run
        	var runLabel = View.findDrawableById("RunLabel");
        	runLabel.setFont(Graphics.FONT_MEDIUM);
        	runLabel.setLocation(WatchUi.LAYOUT_HALIGN_CENTER, 160);
        	if (isFr230) {
        		runLabel.setLocation(WatchUi.LAYOUT_HALIGN_CENTER, 130);
        	}
	        // Percent battery
	        var systemStats = System.getSystemStats();
	        var battery = System.getSystemStats().battery;
	        var batteryDisplay = battery.format("%02d");
	       	var percentBatteryLabel = View.findDrawableById("PercentBatteryLabel");
	        percentBatteryLabel.setText(batteryDisplay + "%"); 
	        percentBatteryLabel.setLocation(WatchUi.LAYOUT_HALIGN_CENTER, 5);
    	}
	        
        // Refresh
    	View.onUpdate(dc);
    	  	
	 	// Time
    	var timeColor = Graphics.COLOR_WHITE;
    	var timeFont  = "";
    	if (is920xt) {
    		timeFont  = Graphics.FONT_SYSTEM_NUMBER_THAI_HOT;
    	} else if (isFenix5 || isFenix5S) {
    		timeFont  = Graphics.FONT_SYSTEM_NUMBER_MEDIUM;
    	} else if (isFr230) {
    		timeFont  = Graphics.FONT_SYSTEM_NUMBER_HOT;
    	}
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Application.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        var time = new WatchUi.Text({
            :text  => timeString,
            :color => timeColor,
            :font  => timeFont,
            :locX  => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY  => WatchUi.LAYOUT_VALIGN_CENTER
        });
        time.draw(dc);
                
    	// Swim
		swim.draw(dc);
		// Bike
		bike.draw(dc);
		if (is920xt) {
			// Run
			run.draw(dc);
			// Day
    		day.draw(dc);
    		// Percent battery
			percentBattery.draw(dc);
    	}
    }

    function onHide() {}
    function onExitSleep() {}
    function onEnterSleep() {}
}
