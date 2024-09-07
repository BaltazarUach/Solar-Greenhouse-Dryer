clc
clearvars
close all

Mc1_1 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C2:C26'));  % 07:00 A 19:00
Mc1_2 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C27:C51'));  % 07:00 A 19:00
Mc1_3 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C52:C76'));   % 07:00 A 19:00
Mc1_4 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C77:C100'));  % 07:00 A 18:30
Mc2_1 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C101:C125'));  % 07:00 A 19:00
Mc2_2 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C126:C150'));  % 07:00 A 19:00
Mc2_3 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C151:C175'));  % 07:00 A 19:00
Mc2_4 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C176:C199'));  % 07:00 A 18:30
Mc3_1 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C200:C224'));  % 07:00 A 19:00
Mc3_2 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C225:C249'));  % 07:00 A 19:00
Mc3_3 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C250:C272'));  % 07:00 A 18:00
Mc3_4 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C273:C296'));  % 07:00 A 18:30
Mc3_5 = table2array(readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','C297:C320'));  % 07:00 A 18:30

Time = (minutes(0):minutes(30):minutes(720))';  % 07:00 A 19:00
Time1 = (minutes(0):minutes(30):minutes(690))';  % 07:00 A 18:30
Time2 = (minutes(0):minutes(30):minutes(660))';  % 07:00 A 18:30

TT1 = timetable(Time,Mc1_1,Mc1_2,Mc1_3,Mc2_1,Mc2_2,Mc2_3,Mc3_1,Mc3_2);
TT2 = timetable(Time1,Mc1_4,Mc2_4,Mc3_4,Mc3_5);
TT3 = timetable(Time2,Mc3_3);

TT_1 = retime(TT1,'minutely','linear');
TT_2 = retime(TT2,'minutely','linear');
TT_3 = retime(TT3,'minutely','linear');




%% 
clc
clearvars
Mc1_1 = readtable('Datos.xlsx','Sheet','Sheet1', ...
    'Range','B2:C26');  % 07:00 A 19:00







