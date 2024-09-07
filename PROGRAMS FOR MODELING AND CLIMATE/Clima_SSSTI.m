
% Clima durante los experimentos de secado

% BALTAZAR LOPEZ VELASCO 

clc
clearvars
close all

Data = table2array(readtable('Datos.xlsx','Sheet',...
    'Sheet4','Range','C2:I9194'));

t1 = (1:1:721)';

% Variables Experimento 1
Ta1_d1 = Data(1:721,1);
Tamb1_d1 = Data(1:721,2);
RHamb1_d1 = Data(1:721,3);
Rg1_d1 = Data(1:721,4);
t_ext1_d1 = Data(1:721,5);
RH1_d1 = Data(1:721,6);



Ta1_d2 = Data(722:1442,1);
Tamb1_d2 = Data(722:1442,2);
RHamb1_d2 = Data(722:1442,3);
Rg1_d2 = Data(722:1442,4);
t_ext1_d2 = Data(722:1442,5);
RH1_d2 = Data(722:1442,6);

t2 = (722+100:1:1442+100)';

Ta1_d3 = Data(1443:2163,1);
Tamb1_d3 = Data(1443:2163,2);
RHamb1_d3 = Data(1443:2163,3);
Rg1_d3 = Data(1443:2163,4);
t_ext1_d3 = Data(1443:2163,5);
RH1_d3 = Data(1443:2163,6);

t3 = (1443+200:1:2163+200)';

Ta1_d4 = Data(2164:2854,1);
Tamb1_d4 = Data(2164:2854,2);
RHamb1_d4 = Data(2164:2854,3);
Rg1_d4 = Data(2164:2854,4);
t_ext1_d4 = Data(2164:2854,5);
RH1_d4 = Data(2164:2854,6);


t4 = (2164+300:1:2854+300)';

% Gráfica de temperatura exp1
figure
plot(t1,Ta1_d1,'-b',t1,Tamb1_d1,'-.r','LineWidth',0.8)
hold on
plot(t2,Ta1_d2,'-b',t2,Tamb1_d2,'-.r','LineWidth',0.8)
hold on
plot(t3,Ta1_d3,'-b',t3,Tamb1_d3,'-.r','LineWidth',0.8)
hold on
plot(t4,Ta1_d4,'-b',t4,Tamb1_d4,'-.r','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 70];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 70];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 70];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('T_a','T_a_m_b')
xlabel('Hora del día (h)')
ylabel('Temperatura (°C)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)

% Gráfica de humedad relativa exp 1
figure
plot(t1,RH1_d1,'-b',t1,RHamb1_d1,'-.r','LineWidth',0.8)
hold on
plot(t2,RH1_d2,'-b',t2,RHamb1_d2,'-.r','LineWidth',0.8)
hold on
plot(t3,RH1_d3,'-b',t3,RHamb1_d3,'-.r','LineWidth',0.8)
hold on
plot(t4,RH1_d4,'-b',t4,RHamb1_d4,'-.r','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 90];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 90];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 90];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('RH','RH_a_m_b')
xlabel('Hora del día (h)')
ylabel('Humedad relativa (%)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)

% Gráfica de radiacion solar global exp 1
figure
plot(t1,Rg1_d1,'-b','LineWidth',0.8)
hold on
plot(t2,Rg1_d2,'-b','LineWidth',0.8)
hold on
plot(t3,Rg1_d3,'-b','LineWidth',0.8)
hold on
plot(t4,Rg1_d4,'-b','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 1200];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 1200];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 1200];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('R_g')
xlabel('Hora del día (h)')
ylabel('Radiación solar global (W m^-^2)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)


%%

%  Variables exp 2
Ta2_d1 = Data(2855:3575,1);
Tamb2_d1 = Data(2855:3575,2);
RHamb2_d1 = Data(2855:3575,3);
Rg2_d1 = Data(2855:3575,4);
t_ext2_d1 = Data(2855:3575,5);
RH2_d1 = Data(2855:3575,6);


Ta2_d2 = Data(3576:4296,1);
Tamb2_d2 = Data(3576:4296,2);
RHamb2_d2 = Data(3576:4296,3);
Rg2_d2 = Data(3576:4296,4);
t_ext2_d2 = Data(3576:4296,5);
RH2_d2 = Data(3576:4296,6);

Ta2_d3 = Data(4297:5017,1);
Tamb2_d3 = Data(4297:5017,2);
RHamb2_d3 = Data(4297:5017,3);
Rg2_d3 = Data(4297:5017,4);
t_ext2_d3 = Data(4297:5017,5);
RH2_d3 = Data(4297:5017,6);

Ta2_d4 = Data(5018:5708,1);
Tamb2_d4 = Data(5018:5708,2);
RHamb2_d4 = Data(5018:5708,3);
Rg2_d4 = Data(5018:5708,4);
t_ext2_d4 = Data(5018:5708,5);
RH2_d4 = Data(5018:5708,6);

% Gráfica de temperatura exp2
figure
plot(t1,Ta2_d1,'-b',t1,Tamb2_d1,'-.r','LineWidth',0.8)
hold on
plot(t2,Ta2_d2,'-b',t2,Tamb2_d2,'-.r','LineWidth',0.8)
hold on
plot(t3,Ta2_d3,'-b',t3,Tamb2_d3,'-.r','LineWidth',0.8)
hold on
plot(t4,Ta2_d4,'-b',t4,Tamb2_d4,'-.r','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 70];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 70];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 70];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('T_a','T_a_m_b')
xlabel('Hora del día (h)')
ylabel('Temperatura (°C)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)


% Gráfica de humedad relativa exp 2
figure
plot(t1,RH2_d1,'-b',t1,RHamb2_d1,'-.r','LineWidth',0.8)
hold on
plot(t2,RH2_d2,'-b',t2,RHamb2_d2,'-.r','LineWidth',0.8)
hold on
plot(t3,RH2_d3,'-b',t3,RHamb2_d3,'-.r','LineWidth',0.8)
hold on
plot(t4,RH2_d4,'-b',t4,RHamb2_d4,'-.r','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 100];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 100];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 100];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('RH','RH_a_m_b')
xlabel('Hora del día (h)')
ylabel('Humedad relativa (%)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)

% Gráfica de radiacion solar global exp 2
figure
plot(t1,Rg2_d1,'-b','LineWidth',0.8)
hold on
plot(t2,Rg2_d2,'-b','LineWidth',0.8)
hold on
plot(t3,Rg2_d3,'-b','LineWidth',0.8)
hold on
plot(t4,Rg2_d4,'-b','LineWidth',0.8)
hold on 
X1=[772 772]; Y1=[0 1400];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[1593 1593]; Y2=[0 1400];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on
X3=[2414 2414]; Y3=[0 1400];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
legend('R_g')
xlabel('Hora del día (h)')
ylabel('Radiación solar global (W m^-^2)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2363 2464 2704 2944 3154])
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','19:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)



%%

% Variables exp 3
Ta3_d1 = Data(5709:6429,1);
Tamb3_d1 = Data(5709:6429,2);
RHamb3_d1 = Data(5709:6429,3);
Rg3_d1 = Data(5709:6429,4);
t_ext3_d1 = Data(5709:6429,5);
RH3_d1 = Data(5709:6429,6);

t1_1 = (1:1:721)';

Ta3_d2 = Data(6430:7150,1);
Tamb3_d2 = Data(6430:7150,2);
RHamb3_d2 = Data(6430:7150,3);
Rg3_d2 = Data(6430:7150,4);
t_ext3_d2 = Data(6430:7150,5);
RH3_d2 = Data(6430:7150,6);

t2_2 = (722+100:1:1442+100)';

Ta3_d3 = Data(7151:7811,1);
Tamb3_d3 = Data(7151:7811,2);
RHamb3_d3 = Data(7151:7811,3);
Rg3_d3 = Data(7151:7811,4);
t_ext3_d3 = Data(7151:7811,5);
RH3_d3 = Data(7151:7811,6);

t3_3 = (1443+200:1:2103+200)';

Ta3_d4 = Data(7812:8502,1);
Tamb3_d4 = Data(7812:8502,2);
RHamb3_d4 = Data(7812:8502,3);
Rg3_d4 = Data(7812:8502,4);
t_ext3_d4 = Data(7812:8502,5);
RH3_d4 = Data(7812:8502,6);

t4_4 = (2104+300:2794+300)';

Ta3_d5 = Data(8503:9193,1);
Tamb3_d5 = Data(8503:9193,2);
RHamb3_d5 = Data(8503:9193,3);
Rg3_d5 = Data(8503:9193,4);
t_ext3_d5 = Data(8503:9193,5);
RH3_d5 = Data(8503:9193,6);

t5_5 = (2795+400:3485+400)';

% a1 = max (Rg3_d1)
% a2 =  max (Rg3_d2)
% a3 = max (Rg3_d3)
% a4 =  max (Rg3_d4)
% a5 =  max (Rg3_d5)
% 
% A = [a1,a2,a3,a4,a5]
% max_Rg = max(A)


% Gráfica de temperatura exp3
figure
plot(t1_1,Ta3_d1,'-b',t1_1,Tamb3_d1,'-.r','LineWidth',0.8)
hold on
plot(t2_2,Ta3_d2,'-b',t2_2,Tamb3_d2,'-.r','LineWidth',0.8)
hold on
plot(t3_3,Ta3_d3,'-b',t3_3,Tamb3_d3,'-.r','LineWidth',0.8)
hold on
plot(t4_4,Ta3_d4,'-b',t4_4,Tamb3_d4,'-.r','LineWidth',0.8)
hold on
plot(t5_5,Ta3_d5,'-b',t5_5,Tamb3_d5,'-.r','LineWidth',0.8)
hold on 
X1_1=[772 772]; Y1_1=[0 70];
line(X1_1,Y1_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2_1=[1593 1593]; Y2_1=[0 70];
line(X2_1,Y2_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X3_1=[2354 2354]; Y3_1=[0 70];
plot(X3_1,Y3_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X4_1=[3145 3145]; Y4_1=[0 70];
line(X4_1,Y4_1,'color','k','LineStyle','--','LineWidth',1)
legend('T_a','T_a_m_b')
xlabel('Hora del día (h)')
ylabel('Temperatura (°C)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2303 2404 2644 2884 3094 3195 3435 3675 3885] )
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','18:00','07:00','11:00','15:00','18:30' ...
    '07:00','11:00','15:00','18:30'})
xtickangle(-90)


% Gráfica de Humedad relativa exp3
figure
plot(t1_1,RH3_d1,'-b',t1_1,RHamb3_d1,'-.r','LineWidth',0.8)
hold on
plot(t2_2,RH3_d2,'-b',t2_2,RHamb3_d2,'-.r','LineWidth',0.8)
hold on
plot(t3_3,RH3_d3,'-b',t3_3,RHamb3_d3,'-.r','LineWidth',0.8)
hold on
plot(t4_4,RH3_d4,'-b',t4_4,RHamb3_d4,'-.r','LineWidth',0.8)
hold on
plot(t5_5,RH3_d5,'-b',t5_5,RHamb3_d5,'-.r','LineWidth',0.8)
hold on 
X1_1=[772 772]; Y1_1=[0 100];
line(X1_1,Y1_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2_1=[1593 1593]; Y2_1=[0 100];
line(X2_1,Y2_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X3_1=[2354 2354]; Y3_1=[0 100];
plot(X3_1,Y3_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X4_1=[3145 3145]; Y4_1=[0 100];
line(X4_1,Y4_1,'color','k','LineStyle','--','LineWidth',1)
legend('RH','RH_a_m_b')
xlabel('Hora del día (h)')
ylabel('Humedad relativa (%)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2303 2404 2644 2884 3094 3195 3435 3675 3885] )
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','18:00','07:00','11:00','15:00','18:30' ...
    '07:00','11:00','15:00','18:30'})
xtickangle(-90)


% Gráfica de Radiación solar global exp3
figure
plot(t1_1,Rg3_d1,'-b','LineWidth',0.8)
hold on
plot(t2_2,Rg3_d2,'-b','LineWidth',0.8)
hold on
plot(t3_3,Rg3_d3,'-b','LineWidth',0.8)
hold on
plot(t4_4,Rg3_d4,'-b','LineWidth',0.8)
hold on
plot(t5_5,Rg3_d5,'-b','LineWidth',0.8)
hold on 
X1_1=[772 772]; Y1_1=[0 1200];
line(X1_1,Y1_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2_1=[1593 1593]; Y2_1=[0 1200];
line(X2_1,Y2_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X3_1=[2354 2354]; Y3_1=[0 1200];
plot(X3_1,Y3_1,'color','k','LineStyle','--','LineWidth',1)
hold on
X4_1=[3145 3145]; Y4_1=[0 1200];
line(X4_1,Y4_1,'color','k','LineStyle','--','LineWidth',1)
legend('R_g')
xlabel('Hora del día (h)')
ylabel('Radiación solar global (W m^-^2)')
xticks([1 241 481 722 822 1062 1302 1542 1643 1883 2123 2303 2404 2644 2884 3094 3195 3435 3675 3885] )
xticklabels({'07:00','11:00','15:00','19:00','07:00','11:00','15:00', ...
    '19:00','07:00','11:00','15:00','18:00','07:00','11:00','15:00','18:30' ...
    '07:00','11:00','15:00','18:30'})
xtickangle(-90)

%% Contenido de Humedad 

clc
clearvars
close all

Mwb_SSSTI = table2array(readtable('Datos.xlsx','Sheet',...
    'Sheet7','Range','C1:C319'));

Mwb_amb = table2array(readtable('Datos.xlsx','Sheet',...
    'Sheet7','Range','G1:G500'));
% 
% Mwb_amb_exp1_d1 = Mwb_amb(1:25,1);
% t1=(1:1:25)';
% Mwb_amb_exp1_d2 = Mwb_amb(26:42,1);
% t2=(26:1:42)';
% Mwb_amb_exp1_d3 = Mwb_amb(51:75,1);
% t3=(51:1:75)';
% Mwb_amb_exp1_d4 = Mwb_amb(76:95,1);
% t4=(76:1:95)';
% Mwb_amb_exp1_d4 = Mwb_amb(10:111,1);
% t4=(76:1:95)';
% 
% Mwb_amb_exp1_d2 = Mwb_SSSTI(26:50,1);
% Mwb_amb_exp1_d3 = Mwb_SSSTI(51:75,1);
% Mwb_amb_exp1_d4 = Mwb_SSSTI(76:99,1);

Mwb_SSSTI_exp1 = Mwb_SSSTI(1:99,1);
t_exp1 = (1:1:99)';
% 
% figure
% plot(t_exp1,Mwb_SSSTI_exp1,'-b','LineWidth',2)
% hold on 
% X1=[25 25]; Y1=[20 80];
% line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X2=[50 50]; Y2=[20 80];
% line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X3=[75 75]; Y3=[20 80];
% line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% xlabel('Hora del día (h)')
% ylabel('M_w_b (%)')
% xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
% xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00','11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
% xtickangle(-90)

Mwb_SSSTI_exp2 = Mwb_SSSTI(100:198,1);
t_exp2 = (1:1:99)';
% 
% figure
% plot(t_exp2,Mwb_SSSTI_exp2,'-b','LineWidth',2)
% hold on 
% X1=[25 25]; Y1=[10 80];
% line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X2=[50 50]; Y2=[10 80];
% line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X3=[75 75]; Y3=[10 80];
% line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% xlabel('Hora del día (h)')
% ylabel('M_w_b (%)')
% xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
% xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
%     '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
% xtickangle(-90)


Mwb_SSSTI_exp3 = Mwb_SSSTI(199:319,1);
t_exp3 = (1:1:121)';
% 
% figure
% plot(t_exp3,Mwb_SSSTI_exp3,'-b','LineWidth',2)
% hold on 
% X1=[25 25]; Y1=[10 80];
% line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% hold on
% X2=[50 50]; Y2=[10 80];
% line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X3=[73 73]; Y3=[10 80];
% line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% hold on 
% X4=[97 97]; Y4=[10 80];
% line(X4,Y4,'color','k','LineStyle','--','LineWidth',1)
% xlabel('Hora del día (h)')
% ylabel('M_w_b (%)')
% xticks([1 9 17 25 28 36 44 51 59 67 74 82 90 98 106 114 121])
% xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00','11:00', ...
%     '15:00','07:00','11:00','15:00','07:00','11:00','15:00','18:30'})
% xtickangle(-90)


figure
tiledlayout(3,1)
nexttile
plot(t_exp2,Mwb_SSSTI_exp2,'-b','LineWidth',2)
hold on 
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on 
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[75 75]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
title('(a)')
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
    '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
xtickangle(-90)
nexttile
plot(t_exp2,Mwb_SSSTI_exp2,'-b','LineWidth',2)
hold on 
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on 
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[75 75]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
title('(b)')
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
    '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
xtickangle(-90)
nexttile
plot(t_exp3,Mwb_SSSTI_exp3,'-b','LineWidth',2)
hold on 
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[73 73]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
hold on 
X4=[97 97]; Y4=[10 80];
line(X4,Y4,'color','k','LineStyle','--','LineWidth',1)
title('(c)')
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
xticks([1 9 17 25 30 38 46 51 59 67 74 82 90 98 106 114 121])
xticklabels({'07:00','11:00','15:00','19:00','09:00','13:00','17:00','07:00','11:00', ...
    '15:00','07:00','11:00','15:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)


%%     ****   SECADO CONTINUO   ******
% % % % 
% % % % clc
% % % % clearvars
% % % % close all
% % % % 
% % % % Mwb_SSSTI = table2array(readtable('Datos.xlsx','Sheet',...
% % % %     'Hoja1','Range','C1:C320'));
% % % % 
% % % % 
% % % % Mwb_SSSTI_exp1 = Mwb_SSSTI(1:99,1);
% % % % t_exp1 = (1:1:99)';
% % % % 
% % % % 
% % % % Mwb_SSSTI_exp2 = Mwb_SSSTI(100:198,1);
% % % % t_exp2 = (1:1:99)';
% % % % 
% % % % 
% % % % Mwb_SSSTI_exp3 = Mwb_SSSTI(199:320,1);
% % % % t_exp3 = (1:1:122)';
% % % % 
% % % % 
% % % % figure
% % % % tiledlayout(3,1)
% % % % nexttile
% % % % plot(t_exp2,Mwb_SSSTI_exp2,'-b','LineWidth',2)
% % % % % hold on 
% % % % % X1=[25 25]; Y1=[10 80];
% % % % % line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X2=[50 50]; Y2=[10 80];
% % % % % line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X3=[75 75]; Y3=[10 80];
% % % % % line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% % % % % title('(a)')
% % % % xlabel('Hora del día (h)')
% % % % ylabel('M_w_b (%)')
% % % % xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
% % % % xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
% % % %     '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
% % % % xtickangle(-90)
% % % % nexttile
% % % % plot(t_exp2,Mwb_SSSTI_exp2,'-b','LineWidth',2)
% % % % % hold on 
% % % % % X1=[25 25]; Y1=[10 80];
% % % % % line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X2=[50 50]; Y2=[10 80];
% % % % % line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X3=[75 75]; Y3=[10 80];
% % % % % line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% % % % % title('(b)')
% % % % xlabel('Hora del día (h)')
% % % % ylabel('M_w_b (%)')
% % % % xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
% % % % xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
% % % %     '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
% % % % xtickangle(-90)
% % % % nexttile
% % % % plot(t_exp3,Mwb_SSSTI_exp3,'-b','LineWidth',2)
% % % % hold on 
% % % % % X1=[25 25]; Y1=[10 80];
% % % % % line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on
% % % % % X2=[50 50]; Y2=[10 80];
% % % % % line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X3=[73 73]; Y3=[10 80];
% % % % % line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
% % % % % hold on 
% % % % % X4=[97 97]; Y4=[10 80];
% % % % % line(X4,Y4,'color','k','LineStyle','--','LineWidth',1)
% % % % % title('(c)')
% % % % xlabel('Hora del día (h)')
% % % % ylabel('M_w_b (%)')
% % % % xticks([1 9 17 25 30 38 46 51 59 67 75 83 91 99 107 115 122])
% % % % xticklabels({'07:00','11:00','15:00','19:00','09:00','13:00','17:00','07:00','11:00', ...
% % % %     '15:00','07:00','11:00','15:00','07:00','11:00','15:00','18:30'})
% % % % xtickangle(-90)

%%


% **********************************************************************
%
%                    CONTENIDO DE HUMEDAD 
%
% **********************************************************************


clc
clearvars
close all


% SECADO INTERMITENTE 
Mwb_SSSTI = table2array(readtable('Datos.xlsx','Sheet',...
    'Sheet7','Range','C1:C319'));
Mwb_SSSTI_exp1 = Mwb_SSSTI(1:99,1);
t_exp1 = (1:1:99)';
Mwb_SSSTI_exp2 = Mwb_SSSTI(100:198,1);
t_exp2 = (1:1:99)';
Mwb_SSSTI_exp3 = Mwb_SSSTI(199:319,1);
t_exp3 = (1:1:121)';


% SECADO CONTINUO
Mwb_SSSTI_1 = table2array(readtable('Datos.xlsx','Sheet',...
    'Hoja1','Range','C1:C320'));
Mwb_SSSTI_exp1_1 = Mwb_SSSTI_1(1:99,1);
Mwb_SSSTI_exp2_1 = Mwb_SSSTI_1(100:198,1);
Mwb_SSSTI_exp3_1 = Mwb_SSSTI_1(199:319,1);





figure
tiledlayout(3,1)
nexttile
plot(t_exp1,Mwb_SSSTI_exp1_1,'-b',t_exp1,Mwb_SSSTI_exp1,'--r','LineWidth',2)
hold on 
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on 
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[75 75]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
legend('M_w_b: D - N','M_w_b: D')
xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
    '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
xtickangle(-90)
nexttile
plot(t_exp2,Mwb_SSSTI_exp2_1,'-b',t_exp2,Mwb_SSSTI_exp2,'--r','LineWidth',2)
hold on 
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on 
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[75 75]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
legend('M_w_b: D - N','M_w_b: D')
xticks([1 9 17 25 28 36 44 51 59 67 75 78 86 94 99])
xticklabels({'07:00','11:00','15:00','19:00','08:00','12:00','16:00','07:00', ...
    '11:00','15:00','19:00','08:00','12:00','16:00','18:30'})
xtickangle(-90)
nexttile
plot(t_exp3,Mwb_SSSTI_exp3_1,'-b','LineWidth',2)
hold on 
plot(t_exp3,Mwb_SSSTI_exp3,'--r','LineWidth',2)
hold on
X1=[25 25]; Y1=[10 80];
line(X1,Y1,'color','k','LineStyle','--','LineWidth',1)
hold on
X2=[50 50]; Y2=[10 80];
line(X2,Y2,'color','k','LineStyle','--','LineWidth',1)
hold on 
X3=[73 73]; Y3=[10 80];
line(X3,Y3,'color','k','LineStyle','--','LineWidth',1)
hold on 
X4=[97 97]; Y4=[10 80];
line(X4,Y4,'color','k','LineStyle','--','LineWidth',1)
xlabel('Hora del día (h)')
ylabel('M_w_b (%)')
legend('M_w_b: D - N','M_w_b: D')
xticks([1 9 17 25 30 38 46 51 59 67 74 82 90 98 106 114 121])
xticklabels({'07:00','11:00','15:00','19:00','09:00','13:00','17:00','07:00','11:00', ...
    '15:00','07:00','11:00','15:00','07:00','11:00','15:00','18:30'})
xtickangle(-90)




