
% M_w.b. PREDICTION USING RECURSIVE MODELS
% Forget factor 
% Kalman filter
% Normalized gradient

% BALTAZAR LOPEZ VELASCO 

clc
clearvars
close all

format long

% Lectura de datos del archivo exel
Data = table2array(readtable('Datos.xlsx','Sheet',...
    'Sheet4','Range','B2:H9194'));

% % % % % % Variables exp 1
% % Mc_1 = Data(1:2854,1);
% % Ta_1 = Data(1:2854,2);
% % Tamb_1 = Data(1:2854,3);
% % RHamb_1 = Data(1:2854,4);
% % Rg_1 = Data(1:2854,5);
% % t_ext_1 = Data(1:2854,6);
% % RH_1 = Data(1:2854,7);

% 
% % % % Variables exp 2
% Mc_2 = Data(2855:5708,1);
% Ta_2 = Data(2855:5708,2);
% Tamb_2 = Data(2855:5708,3);
% RHamb_2 = Data(2855:5708,4);
% Rg_2 = Data(2855:5708,5);
% t_ext_2 = Data(2855:5708,6);
% RH_2 = Data(2855:5708,7);

% % 
% % Variables exp 3
Mc_3 = Data(5709:9193,1);
Ta_3 = Data(5709:9193,2);
Tamb_3 = Data(5709:9193,3);
RHamb_3 = Data(5709:9193,4);
Rg_3 = Data(5709:9193,5);
t_ext_3 = Data(5709:9193,6);
RH_3 = Data(5709:9193,7);

Rg = Rg_3;

% filtro de la radiación solar
alfaFiltro = 0.8;
nData = length(Rg);
RgAux = zeros(nData,1);
RgAux(1) = Rg(1);
for i=2:nData
    RgAux(i) = alfaFiltro *RgAux(i-1)+(1-alfaFiltro )*Rg(i);
end
Rg = RgAux;



% Input/Output Data           
Input = [Ta_3 RH_3 t_ext_3]';
Output = Mc_3';
nDatos = length(Input);

d = 2;

na = d;         % Number of poles
nb = [d d d];   % Number of zeros
nk = [d d d];   % Number of input samples that occur before the input
                % affects the output (dead time) 

% % %       % % % Factor de olvido
% A0 = [1, -1.283549911, 0.284276291];  
% B0 = [0, 0, -2.30E-04, 3.28E-04
% 0, 0, 0.000657348, 5.36E-05
% 0, 0, -1.31E-04, -2.56E-04];

% %       % % % Filtro de Kalman
% A0 = [1, -0.998212708536251, -0.00118789748020362];  
% B0 = [0, 0	8.19573239488316e-05, 0.000159037827080226
% 0, 0, 0.000113891668860677, 0.000209316389935848
% 0, 0, 1.99993957970097e-05, -7.27616534283976e-05];

% %       % % % Gradiente Normalizado
A0 = [1, -0.999889421311421, 3.00064986857728e-05];  
B0 = [0, 0, 0.000107785958171355, 0.000111439113050543
0, 0, -6.23619051246071e-05, -7.79547659716374e-05
0, 0, 7.27489481473333e-07, -4.52826066329708e-07];

% Funcion de Matlab para modelos ARX en linea
obj = recursiveARX([na,nb,nk], A0, B0); 
% obj = recursiveARX([na,nb,nk]);
% obj.EstimationMethod = 'ForgettingFactor';
% obj.ForgettingFactor = 0.995;  % Typical choices of λ are in the range [0.98 0.995].
% obj.EstimationMethod = 'KalmanFilter';
obj.EstimationMethod = 'NormalizedGradient';

yp = zeros(nDatos,1);
for i = 1:nDatos
    [A,B,EstimatedOutput] = step(obj,Output(i),Input(:,i));
    yp(i,1) = EstimatedOutput;
end

% Salida de datos
Out = Output(d+2:end);
ysim = yp(d+2:end,1);

tp = (4:length(Output));


% tp = (2:length(Output)-1);
% to = (1:length(Output));


% 
% % Out_exp1 = Out;
% % Out_exp2 = Out;
Out_exp3 = Out;
% 
% % ysim_exp1 = ysim;
% % ysim_exp2 = ysim;
ysim_exp3 = ysim;
% 
% % t_exp1 = t;
% % t_exp2 = t;
% % t_exp3 = t;
% 
% 
% % Goodness of Fit
Media = mean(Out);
MSE = sum((Out-ysim').^2)/length(Out); % Mean square error 
MAE = sum(Out-ysim')/length(Out);      % Mean absolute error 
R = 1-sum((ysim'-Out).^2)/sum((Media-Out).^2); % Determination coefficient 
% 
% disp(MSE)
% disp(MAE)    
% disp(R)
% 
% 
% % % Plot of Predicted vs. Observed Data
% figure
% plot(t,Out','--b','LineWidth',2)
% hold on
% plot(t,ysim,':r','LineWidth',1.5)
% legend('Observada', 'Predicha');
% xlabel('Tiempo [min]');
% ylabel('Contenido de humedad [% w.b.]' );

% figure
% subplot(2,2,[1,2])
% plot(t_exp1,Out_exp1','--b','LineWidth',2)
% hold on
% plot(t_exp1,ysim_exp1,':r','LineWidth',1.5)
% title('Experimento 1')
% legend('Observada', 'Predicha');
% xlabel('Tiempo [min]');
% ylabel('Contenido de humedad [% w.b.]' );
% xticks([0 500 1000 1500 2000 2500 3000])
% xticklabels({'7:04','12:00','15:00','18:00','07:00','15:00'})
% subplot(2,2,3)
% plot(t_exp2,Out_exp2','--b','LineWidth',2)
% hold on
% plot(t_exp2,ysim_exp2,':r','LineWidth',1.5)
% title('Experimento 2')
% legend('Observada', 'Predicha');
% xlabel('Tiempo [min]');
% ylabel('Contenido de humedad [% w.b.]' );
% subplot(2,2,4)
% plot(t_exp3,Out_exp3','--b','LineWidth',2)
% hold on
% plot(t_exp3,ysim_exp3,':r','LineWidth',1.5)
% title('Experimento 3')
% legend('Observada', 'Predicha');
% xlabel('Tiempo [min]');
% ylabel('Contenido de humedad [% w.b.]' );

% 
% % %% Grafica en el tiempo
% % Primer experimento
% newTimes = (datetime('2023-03-11 07:00:00'):minutes(1):datetime('2023-03-11 19:00:00'))';
% newTimes_1 = (datetime('2023-03-12 07:00:00'):minutes(1):datetime('2023-03-12 19:00:00'))';
% newTimes_2 = (datetime('2023-03-13 07:00:00'):minutes(1):datetime('2023-03-13 19:00:00'))';
% newTimes_3 = (datetime('2023-03-14 07:00:00'):minutes(1):datetime('2023-03-14 18:30:00'))';
% 
% % Time = [newTimes;newTimes_1;newTimes_2;newTimes_3];
% % 
% t2 = Time(4:end,1)

% % % % %% Grafica en el tiempo
% % % Segundo experimento
% % newTimes = (datetime('2023-03-18 07:00:00'):minutes(1):datetime('2023-03-18 19:00:00'))';
% % newTimes_1 = (datetime('2023-03-19 07:00:00'):minutes(1):datetime('2023-03-19 19:00:00'))';
% % newTimes_2 = (datetime('2023-03-20 07:00:00'):minutes(1):datetime('2023-03-20 19:00:00'))';
% % newTimes_3 = (datetime('2023-03-21 07:00:00'):minutes(1):datetime('2023-03-21 18:30:00'))';
% % 
% % Time = [newTimes;newTimes_1;newTimes_2;newTimes_3];
% % % 
% % t2 = Time(4:end,1);

% % %% Grafica en el tiempo
% Tercer experimento
newTimes = (datetime('2023-03-26 07:00:00'):minutes(1):datetime('2023-03-26 19:00:00'))';
newTimes_1 = (datetime('2023-03-27 07:00:00'):minutes(1):datetime('2023-03-27 19:00:00'))';
newTimes_2 = (datetime('2023-03-28 07:00:00'):minutes(1):datetime('2023-03-28 18:00:00'))';
newTimes_3 = (datetime('2023-03-29 07:00:00'):minutes(1):datetime('2023-03-29 18:30:00'))';
newTimes_4 = (datetime('2023-03-30 07:00:00'):minutes(1):datetime('2023-03-30 18:30:00'))';


Time = [newTimes;newTimes_1;newTimes_2;newTimes_3;newTimes_4];
% 
t2 = Time(4:end,1);

% % Plot of Predicted vs. Observed Data
figure
plot(t2,Out_exp3','--b','LineWidth',2)
hold on
plot(t2,ysim_exp3,':r','LineWidth',1.5)
legend('Observada', 'Predicha');
xlabel('Fecha');
ylabel('Contenido de humedad [% w.b.]' );


% xticks([1 241 481 721])
% xticklabels({'07:00','11:00','15:00','19:00'})
% xtickangle(-90)

%% input = [Rg Tamb RHamb t_ext]

%       % % % Factor de olvido
% A0 = [1, -1.28354991068120, 0.284276290570049];  
% B0 = [0, 0, -0.000230368862231231, 0.000327604886024444
% 0, 0, 0.000657348129102864, 5.36296352124299e-05
% 0, 0, -0.000130722161133242, -0.000256192982028724];

%       % % Filtro de Kalman 
% A0 = [1, -0.998054960172760, 0.000110494906811859];
% B0 = [0, 0, -9.59088665064389e-06, 8.63431069993313e-06
% 0, 0, 0.00128406109149690, 0.000532664329300896
% 0, 0, 0.000252119075894927, 0.000103326507294622
% 0, 0, 3.09122825304319e-05, -3.96671509155738e-05];

      % % % Gradiente normalizado
% A0 = [1, -0.999913613697546, 6.27757749521653e-06];
% B0 = [0, 0, 2.35537650384497e-05, -8.00694766220185e-06
% 0, 0, -1.58748695440735e-05, -1.57424782851888e-05
% 0, 0, 2.94028105296292e-05, 2.26833342643661e-05
% 0, 0, 1.61816824388310e-08, 8.35065094728287e-09];


%%  input = [Rg Tamb t_ext]

%       % % % Factor de olvido
% A0 = [1, -1.95921368041438, 0.959243389649794];  
% B0 = [0, 0, 1.52455743523304e-06, -2.20307322811898e-06
% 0, 0, 0.000254977864528788, -0.000214816895393240
% 0, 0, -6.60687110165844e-05, 3.28441727884717e-05];

%       % % Filtro de Kalman 
% A0 = [1, -0.997591157195989, -0.00230847398316891];
% B0 = [0, 0, -8.94827956849435e-07, 6.65356956552925e-06
% 0, 0, 5.99861415029189e-05, 5.06020885790145e-05
% 0, 0, 5.59230771440694e-05, -4.99015580733618e-05];

%       % % % Gradiente normalizado
% A0 = [1, -0.999915907814760, 2.33829545855272e-06];
% B0 = [0, 0, 4.77103596409696e-05, 1.35222705226102e-05
% 0, 0, -2.10137623341983e-05, -2.16045482962624e-05
% 0, 0, 1.58757817955789e-08, 7.76090274450978e-09];

%%  Imput = [Tamb RHamb t_ext]

% %       % % % Factor de olvido
% A0 = [1, -1.89753715283501, 0.820078260615799, 0.0775291999571862];  
% B0 = [0, 0, 0, 0.000306853008214772, -0.000366790844721606, 0.000103991580099836
% 0, 0, 0, 2.18928315711645e-05, 2.46646278288607e-05, -2.61103856860660e-05
% 0, 0, 0, -8.79842934212189e-05, 2.09213792519520e-05, -7.58381564372797e-05];

%       % % Filtro de Kalman 
% A0 = [1, -0.998559054007340, -0.000729434259660209];
% B0 = [0, 0, 0.000326023192566061, 0.000268807233031042
% 0, 0, 6.84267032016500e-05, 7.01683308024174e-05
% 0, 0, 6.57470261774846e-06, -3.32937359509112e-05];

%       % % % Gradiente normalizado
% A0 = [1, -0.999969734, -4.92E-05, -4.93E-05];
% B0 = [0, 0, 0.00E+00, 1.23E-04, 0.000127752, 0.000132531
% 0, 0, 0.00E+00, -4.86E-05, -7.63E-05, -9.10E-05
% 0, 0, 0.00E+00, -1.56E-06, 8.05E-07, 1.88E-06];

%%
% 
% % Plot of Predicted vs. Observed Data
% figure
% plot(to,Out,'--b','LineWidth',2)
% legend('Predicha','Observada');
% xlabel('Tiempo [min]');
% ylabel('Contenido de humedad [% w.b.]' );
% xticks([1 241 481 721])
% xticklabels({'07:00','11:00','15:00','19:00'})
% xtickangle(-90)
% hold on
% plot(tp,ysim,':r','LineWidth',1.8)


