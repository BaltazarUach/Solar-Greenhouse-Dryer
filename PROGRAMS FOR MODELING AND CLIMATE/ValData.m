% Validación de los datos

% BALTAZAR LOPEZ VELASCO

clc
clearvars
close all

Data = table2array(readtable('Datos.xlsx','Sheet','Sheet3', ...
    'Range','B2:I16474'));  

Ta_r1 = Data(:,1);
Ta_r2 = Data(:,2);
Ta_1 = Data(:,3);
Ta_2 = Data(:,4);

RH_r1 = Data(:,5);
RH_r2 = Data(:,6);
RH_1 = Data(:,7);
RH_2 = Data(:,8);

yobs = Ta_r2;
ysim = Ta_2;

% Estadisticos
Media = mean(yobs);
EF = 1 - ((sum((yobs-ysim).^2))/(sum((yobs - Media).^2)));
MAE = (sum(yobs-ysim))/length(ysim); 
MSE = sum((yobs-ysim).^2)/length(yobs);
RMSE = sqrt(MSE);
R = 1 - (sum((ysim-yobs).^2))/(sum((ysim).^2));
NRMSE = 100*(1-norm(yobs-ysim)/norm(yobs-Media));

fprintf('Goodness of Fit \n')
fprintf('MSE =')
fprintf('%8.5f\n',MSE)
fprintf('RMSE =')
fprintf('%8.5f\n',RMSE)
fprintf('MAE =')
fprintf('%8.5f\n',MAE)
fprintf('R^2 =')
fprintf('%8.5f\n',R)
fprintf('EF =')
fprintf('%8.5f\n',EF)
fprintf('Fit percent =')
fprintf('%8.5f\n',NRMSE)
