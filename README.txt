IoT-based Environmental Monitoring and Prediction of Banana Moisture Content in a Solar Greenhouse Dryer
1.0 IoT System Programs

This project focuses on the development of an IoT-based system for monitoring environmental conditions and predicting the moisture content of bananas during the drying process in a solar greenhouse dryer. The system integrates various Arduino-based programs for data acquisition, and Matlab scripts for modeling and climate analysis. Below are the details on how to use the provided programs.

The IoT SYSTEM PROGRAMS folder contains the necessary Arduino programs for the monitoring system. Generally, you must make the appropriate connections and upload the corresponding program to each device (Arduino and TTGO LoRa 32).

The ARDUINO_MEGA program corresponds to the primary Arduino.
The ARDUINO_MEGA1 program corresponds to the secondary Arduino.
These programs are used together to acquire temperature and humidity data.

Additionally, the programs prueba1_LoRa_Emisor and LoRa_Receptor_ThingSpeak are responsible for uploading the data to the ThingSpeak platform using LoRa and WiFi protocols.

Finally, the On_Off_Extractor program contains the necessary code to monitor the on/off state of the extractors by measuring electric current consumption.

2.0 Programs for Modeling and Climate Analysis
The PROGRAMS FOR MODELING AND CLIMATE folder contains Matlab programs designed for online ARX model identification and climate behavior analysis. The folder includes the following files:

Mc_ARX_online.m: For online model identification.
Clima_SSSTI.m: For analyzing climate behavior.
ValData.m: For data validation.
McOneMinute.m: For data interpolation.
Datos.xlsx: An Excel file containing the data collected during tests, as well as the results of the modeling process.

3.0 Using the Program Mc_ARX_online.m
The Mc_ARX_online.m file is used for online ARX model identification. Below are the key steps for using this program:

3.1 Selecting Experimental Data (Lines 19 to 46)
You must choose the experimental data to be used for modeling. Comment and uncomment the lines according to the experiment data you want to use for ARX model identification.

3.2 Defining Input Variables (Lines 48 to 65)
Correctly define the input variables for the low-pass filter and the models.

3.3 Defining Delays (Lines 67 to 71)
Define the delays for the input and output data of the models in the appropriate lines.

3.4 Selecting Coefficients for the Estimation Algorithm (Lines 74 to 90)
You need to select the coefficients for the estimation algorithm. Matlab provides three options: forgetting factor, Kalman filter, and normalized gradient. Choose the method that suits your needs.

3.5 Identifying and Predicting the Model (Lines 92 to 104)
Use Matlab’s recursiveARX function for model identification and prediction. While identifying the model, employ the function obj = recursiveARX([na,nb,nk]) to calculate the prediction algorithm coefficients.

Note: Comment all lines containing the coefficient matrices (step 3.3) during identification. Once the coefficients are obtained, use the command obj = recursiveARX([na,nb,nk], A0, B0) to apply the coefficient matrices, uncommenting the method you wish to use.

3.6 Result Analysis (Lines 105 to 222)
Perform the result analysis by commenting and uncommenting the lines according to the experimental data you're working with (step 3.0). The results, including statistics and a graph of the predicted and measured response variables, will be displayed in the Matlab command window.

