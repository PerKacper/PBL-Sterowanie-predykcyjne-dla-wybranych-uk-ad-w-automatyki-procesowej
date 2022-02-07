clear all; close all; clc;
load('Model\zbraszowany_tout.mat');
Tout = {tout15_20(:,2); tout20_25(:,2); tout25_30(:,2); tout30_35(:,2); tout35_40(:,2); tout40_45(:,2); tout45_50(:,2)}; % zrobić z tego wektor toutów
kp = [24 13.8 9.4 6.6 4.8 3.8 3.8];
taup = [60.75 42.3 39.6 41.85 39.15 20.25 30.6];
deltap = [10.95 6 7.8 19.65 17.55 2.85 17.7];

%% wy/we sim:
y0 = [59.8 48.9 42.1 37.4 34 31.6 29.7];
du = 0.5;
i = input("Wybierz numer skoku (1-7): "); % i = 1 ... 7 (na każdy skok)
K = -kp(i)/taup(i);

% Do simulinka, Tout przygotowanie:
ToutWybrane = cell2mat(Tout(i));
toutRealLen = length(ToutWybrane);
toutReal = (0.3:0.3:toutRealLen*0.3)';
toutRealToSim(:,1) = toutReal; toutRealToSim(:,2) = ToutWybrane;

% Do porównania, Tout1: 
Tout1 = cell2mat(Tout(i));
toutRealLen1 = length(Tout1);
toutReal1 = (0.3:0.3:toutRealLen1*0.3)';
toutRealToSim1(:,1) = toutReal1; toutRealToSim1(:,2) = Tout1;

foptd = sim('foptdModel_21a.mdl', toutReal(end)-0.3);

% plotting:
figure;
plot(foptd.tout, foptd.foptd_y, 'LineWidth', 1.1, 'color', 'r');
hold on;
plot(toutReal, ToutWybrane, 'LineWidth', 1.1, 'color', 'b');
grid minor;
title(["Skok nr." + num2str(i) + ": " + num2str(1+0.5*i) + "l na " + num2str(1.5 + 0.5*i) + "l, stała moc grzałki 40%"]);
legend("foptd", "Rzeczywisty");
xlim([0 toutReal(end)]);
MSE = immse(ToutWybrane, foptd.foptd_y);
fprintf("Skok %d, MSE: %f\n", i, MSE)

%% AMIGO:
P = 1/kp(i) * (0.2+0.45 * (taup(i)/deltap(i)));
I = (deltap(i) * (0.4*deltap(i) + 0.8*taup(i)))/(deltap(i)+0.1*taup(i));
D = 0.5*taup(i)*deltap(i) / ( 0.3*deltap(i) + taup(i));
fprintf("AMIGO: P = %f, I = %f, D = %f.\n", P, I, D)