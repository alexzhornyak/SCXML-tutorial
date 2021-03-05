<a name="top-anchor"/>

| [Contents](../../../README.md#table-of-contents) | [Overview](../../../README.md#scxml-overview) | [Examples](../../README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# Qt QML SCXML Infotainment Radio Bolero Simulator
This project is intended to test Qt QML SCXML module for designing in-vehicle infotainment systems 

- [Video description (General)](https://youtu.be/Er-G4Ii6bhs)
- [Video description (MediaPlayer)](https://youtu.be/PSV9UL7_nRQ)

![Preview](Qml/Images/BoleroPreview.gif)

# Description and rules
User interface is separated from internal logic. QML controls do not interact between each other directly. Internal application logic is defined in SCXML file with ECMAScript data model that is compiled into a C++ class. The info about hitting any GUI controls is passed to the state machine that connects their communication interfaces together. Application settings data is based on JSON object which is integrated as [\<data\>](../../../Doc/datamodel.md) element of state machine datamodel

# SCXML model
SCXML model is organized as [SCXMLEditor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) project [Model/projectBolero.sproj](https://raw.githubusercontent.com/alexzhornyak/SCXML-tutorial/master/Examples/Qt/SkodaBoleroInfotainment/Model/projectBolero.sproj).
![main_structure](../../../Images/bolero_main_structure.png)

![display](../../../Images/bolero_display.png)

# Media
## Inputs
- CD slot

![CD](../../../Images/bolero_cd_input.png)

- SD card slot

![SD](../../../Images/bolero_sd_input.png)

- USB
- AUX

![USBandAUX](../../../Images/bolero_usb_and_aux.png)

It is possible to assign drive source via settings
![select_source](../../../Images/bolero_select_source.png)

![select_source2](../../../Images/bolero_select_source_2.png)

## Check inputs
![DriveSources](../../../Images/bolero_driveSources.png)

## Select input
![AudioInputs](../../../Images/bolero_audio_inputs.png)

## MediaPlayer
![MediaPlayer](../../../Images/bolero_mediaPlayer.png)

| [TOP](#top-anchor) | [Contents](../../../README.md#table-of-contents) | [Overview](../../../README.md#scxml-overview) | [Examples](../../README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
