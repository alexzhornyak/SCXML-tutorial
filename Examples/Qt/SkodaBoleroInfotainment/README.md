# Infotainment Radio Bolero Simulator
This project is intended to test Qt QML SCXML module for designing in-vehicle infotainment systems 

![Preview](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Examples/Qt/SkodaBoleroInfotainment/Qml/Images/BoleroPreview.gif)

# Description and rules
User interface is separated from internal logic. QML controls do not interact between each other directly. Internal application logic is defined in SCXML file with ECMAScript data model that is compiled into a C++ class. The info about hitting any GUI controls is passed to the state machine that connects their communication interfaces together. Application settings data is based on JSON object which is integrated as \<data\> element of state machine datamodel
