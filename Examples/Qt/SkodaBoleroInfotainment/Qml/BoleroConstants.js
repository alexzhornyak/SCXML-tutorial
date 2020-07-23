var cl_BACKGROUND = "#2e2a2b"
var cl_BACKGROUND_LIGHT = "#4e4a4b"
var cl_SELECTION = "#3fb93b"
var cl_SELECTION_OPACITY = "#603fb93b"
var cl_ITEM_BORDER = "#bfffffff"
var cl_ITEM_TEXT = "#e6ffffff"
var cl_ITEM_COLOR = "#19ffffff"

var d_BTN_SCALE = 0.95
var d_BTN_OPACITY = 0.9

var i_DISPLAY_PADDING = 8


var d_RADIO_FM_MIN = 88.0
var d_RADIO_FM_MAX = 108.0

var d_RADIO_AM_MIN = 542.0
var d_RADIO_AM_MAX = 1600

function limitMinMax(d_val, d_min, d_max) {
    if (d_val < d_min)
        d_val = d_min
    else if (d_val > d_max)
        d_val = d_max

    return d_val
}
