// true band settings
var d_RADIO_FM_MIN = 87500000;
var d_RADIO_FM_MAX = 108000000;
var d_RADIO_FM_STEP = 100000;
var d_RADIO_AM_MIN = 520000;
var d_RADIO_AM_MAX = 1610000;
var d_RADIO_AM_STEP = 5000;

var t_RADIO_SETUP_DEPENDENCY = {
    "RadioRDS": [ "RadioAF", "RadioAutoSaveLogos", "RadioText", "RadioTraffic" ]
};

var t_RADIO_ARROWS = [ "Preset list", "Station list" ]
var t_RADIO_REGIONAL_RDS = [ "Fixed", "Automatic" ]

var t_MEDIA_AVAILABLE_EXTENSIONS = [ "*.mp3", "*.wav", "*.wma" ]
var t_IMAGE_AVAILABLE_EXTENSIONS = [ "*.png" ]

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

function strStartsText(s_str, s_text) {
    return s_str.toLowerCase().indexOf(s_text.toLowerCase())===0
}

/**
 * Returns a random integer between min (inclusive) and max (inclusive).
 * The value is no lower than min (or the next integer greater than min
 * if min isn't an integer) and no greater than max (or the next integer
 * lower than max if max isn't an integer).
 * Using Math.round() will give you a non-uniform distribution!
 */
function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function compareFileByExtension(s1, s2){
    var s1_delim = s1.lastIndexOf('.');
    var s2_delim = s2.lastIndexOf('.');
    if ((s1_delim !== -1) === (s2_delim !== -1)) { // both or neither

        if (s1_delim !== -1 && s2_delim !== -1) {
            var s1_ext = s1.substring(s1_delim + 1);
            var s2_ext = s2.substring(s2_delim + 1);

            if (s1_ext !== s2_ext)
                return s1_ext.localeCompare(s2_ext)
        }

        return s1.localeCompare(s2);
    } else if (s1_delim === -1) { // only s2 has an extension, so s1 goes first
        return -1;
    } else { // only s1 has an extension, so s1 goes second
        return 1;
    }
}

/* This function accepts only paths without drive !!! */
function compareFileByFolderAndExtension(s1, s2){
    /*
        A_Folder\A_File.mp3
        A_Folder\A_File.wma
        B_Folder\A_File.mp3
        B_Folder\B_File.mp3
        B_Folder\C_File.mp3
        B_Folder\A_File.wma
        A_File.mp3
        B_File.mp3
        A_File.wma
        B_File.wma
    */

    var s1_delim = s1.lastIndexOf('/');
    var s2_delim = s2.lastIndexOf('/');
    if ((s1_delim !== -1) === (s2_delim !== -1)) { // both or neither

        if (s1_delim !== -1 && s2_delim !== -1) {
            var s1_folder = s1.substring(0, s1_delim);
            var s2_folder = s2.substring(0, s2_delim);

            if (s1_folder !== s2_folder)
                return s1_folder.localeCompare(s2_folder)
        }

        return compareFileByExtension(s1, s2);
    } else if (s1_delim === -1) { // only s2 has a folder, so s2 goes first
        return 1;
    } else { // only s1 has a folder, so s1 goes first
        return -1;
    }
}


