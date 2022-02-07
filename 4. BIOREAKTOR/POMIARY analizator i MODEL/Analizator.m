%% PBL Analizator pomiarów z instalacji, umieścić ten plik w folderze z pomiarami w postaci plików .csv i odpalić
% Header w .csv:
%
addpath('hline_vline');
close all;
clear all;
clc;

YourData = load('Data_20_01_22.txt');
csvwrite('Pomiary20012022.csv', YourData);

files = dir('.\*.csv');
fullpaths = fullfile({files.folder}, {files.name});


% 1 kolumna - czas pomiaru [co 0,5 sek]
% 2 kol. - SO - poziom stężenia tlenu
% 3 kol. - bool - aeration

for i=1:1:length(fullpaths)
path = string(fullpaths(i));
[pathstr, name, ext] = fileparts(fullpaths(i));
pomiar = readtable( path, 'NumHeaderLines', 1 ); % Odczyt z pliku csv

% Podział tabeli na parametry
sampleNo = table2array(pomiar(:,1));
time = sampleNo; 
o2Level = table2array(pomiar(:,2));
aeroTF = table2array(pomiar(:,3));

% Skalowanie zmiennych do ich fizycznych wartosci rzeczywistych:
sampleNo = 1:1:length(sampleNo);
time = time';
sampleNo = sampleNo';
% Wykresy:
figure(i)
hold on;
plotHandle = plot(time, o2Level, 'lineWidth', 1.2, 'color', 'blue'); 
plotHandle2 = stairs(time, aeroTF, 'lineWidth', 1.2, 'color', 'magenta'); 
hline(1.9, '--g'); hline(2.1, '--g'); hline(2, 'r');
grid on;
hold off;
legend(["Poziom stężenia tlenu (SO)"], ["Napowietrzenie (T/F)"], 'placement', 'best');
title(name, 'Interpreter', 'none');
xlabel('[h]');
ylabel('Wartości');
xlim([0 time(end)]);
end

% Ts = 0.001;
% u = 1:0.001:length(o2Level);
% data = iddata(o2Level, 2, Ts);
