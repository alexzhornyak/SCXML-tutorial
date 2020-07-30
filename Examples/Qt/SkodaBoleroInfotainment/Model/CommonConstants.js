// true band settings
var d_RADIO_FM_MIN = 87.5;
var d_RADIO_FM_MAX = 108.0;
var d_RADIO_FM_STEP = 0.1
var d_RADIO_AM_MIN = 531.0;
var d_RADIO_AM_MAX = 1602.0;
var d_RADIO_AM_STEP = 5

function limitMinMax(d_val, d_min, d_max) {
    if (d_val < d_min)
        d_val = d_min
    else if (d_val > d_max)
        d_val = d_max

    return d_val
}

function incrementMinMaxWrap(d_val, d_increment, d_min, d_max) {
    d_val += d_increment

    if (d_val>=d_max) {
        d_val = d_min
    } else if (d_val<d_min) {
        d_val = d_max - 1
    }

    return d_val
}
