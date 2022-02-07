%% PBL Analizator pomiarów z instalacji, umieścić ten plik w folderze z pomiarami w postaci plików .csv i odpalić
% Header w .csv:
% Sample,X(ms) [10.12.2014 20:36:13 141 UTC],"Heater_Flow_In[%IW112]","Heater_Tin_In[%IW103]","Heater_Tout_In[%IW122]","Signals_DB.Heater_PWR"
tic
close all;
clc;
files = dir('.\*.csv');
fullpaths = fullfile({files.folder}, {files.name});
iloscWykresow = 0;

for i=1:1:length(fullpaths)
path = string(fullpaths(i));
[pathstr, name, ext] = fileparts(fullpaths(i));
pomiar = readtable( path, 'NumHeaderLines', 1 ); % Odczyt z pliku csv

% Podział tabeli na parametry
sampleNo = table2array(pomiar(:,1));
time = sampleNo(:,1) .* 0.3; %table2array(pomiar(:,2)); % 0.3 s
flowIn = table2array(pomiar(:,3));
heaterTIN = table2array(pomiar(:,4));
heaterTOUT = table2array(pomiar(:,5));
heaterPWR = table2array(pomiar(:,6));

% Skalowanie zmiennych do ich fizycznych wartosci rzeczywistych:
sampleNo = 1:1:length(sampleNo);
time = sampleNo .* 0.3;
flowIn = flowIn ./ 10;
heaterTIN = heaterTIN ./ 10;
heaterTOUT = heaterTOUT ./ 10;
time = time';
sampleNo = sampleNo'
% Wykresy:
figure(i)
hold on;
plotHandle = plot(time, flowIn, 'lineWidth', 1.2); 
plotHandle2 = plot(time, heaterTIN, 'lineWidth', 1.2); 
plotHandle3 = plot(time, heaterTOUT, 'lineWidth', 1.2); 
plotHandle4 = plot(time, heaterPWR, 'lineWidth', 1.2); 
grid on;
hold off;
legend('Przeplyw F_{in} [ l ]', ['T_{in} [ C' char(176) ' ]'], ['T_{out} [ C' char(176) ' ]'], 'Grzałka Moc [ % ]');
title(name, 'Interpreter', 'none');
xlabel('[s]');
ylabel('Wartości');
xlim([0 time(end)]);
iloscWykresow = iloscWykresow + 1;
end

% Ch-ka statyczna
% x - przeplyw, y - moc grzalki, z - Tout
figure(i+1);
plotChkaStat = plot(flowIn, heaterTOUT);
toc