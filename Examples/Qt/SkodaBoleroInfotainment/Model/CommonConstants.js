// true band settings
var d_RADIO_FM_MIN = 87.5;
var d_RADIO_FM_MAX = 108.0;
var d_RADIO_FM_STEP = 0.1
var d_RADIO_AM_MIN = 531.0;
var d_RADIO_AM_MAX = 1602.0;
var d_RADIO_AM_STEP = 5;

var t_RADIO_SETUP_DEPENDENCY = {
    "RadioRDS": [ "RadioAF", "RadioAutoSaveLogos", "RadioText", "RadioTraffic" ]
};

var t_RADIO_ARROWS = [ "Preset list", "Station list" ]
var t_RADIO_REGIONAL_RDS = [ "Fixed", "Automatic" ]

function limitMinMax(d_val, d_min, d_max) {
    if (d_val < d_min)
        d_val = d_min
    else if (d_val > d_max)
        d_val = d_max

    return d_val
}

function incrementMinMaxWrap(i_val, i_increment, i_min, i_max) {
    if (i_increment===0)
        return i_val

    for (var it=0;it<Math.abs(i_increment);it++) {
        var iStep = i_increment/Math.abs(i_increment)
        i_val += iStep

        if (i_val>=i_max) {
            i_val = i_min
        } else if (i_val<i_min) {
            i_val = i_max - 1
        }
    }

    return i_val
}

function incrementArrayWrapCondition(i_val, i_increment, i_max, func_condition) {
	var i_was_val = i_val
    for (var it=0; it<i_max; it++) {
        i_val = incrementMinMaxWrap(i_val, i_increment, 0, i_max)

		if (func_condition(i_val))
			return i_val
    }
	return i_was_val
}
