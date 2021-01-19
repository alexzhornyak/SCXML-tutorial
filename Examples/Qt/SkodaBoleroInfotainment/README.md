# Qt QML SCXML Infotainment Radio Bolero Simulator
This project is intended to test Qt QML SCXML module for designing in-vehicle infotainment systems 

- [Video description (General)](https://youtu.be/Er-G4Ii6bhs)
- [Video description (MediaPlayer)](https://youtu.be/PSV9UL7_nRQ)

![Preview](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Examples/Qt/SkodaBoleroInfotainment/Qml/Images/BoleroPreview.gif)

# Description and rules
User interface is separated from internal logic. QML controls do not interact between each other directly. Internal application logic is defined in SCXML file with ECMAScript data model that is compiled into a C++ class. The info about hitting any GUI controls is passed to the state machine that connects their communication interfaces together. Application settings data is based on JSON object which is integrated as \<data\> element of state machine datamodel

# Media
## Inputs
- CD slot

![CD](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_cd_input.png)

- SD card slot

![SD](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_sd_input.png)

- USB
- AUX

![USBandAUX](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_usb_and_aux.png)

## Check inputs
![DriveSources](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_driveSources.png)

## Select input
![AudioInputs](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_audio_inputs.png)

## MediaPlayer
![MediaPlayer](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/bolero_mediaPlayer.png)
