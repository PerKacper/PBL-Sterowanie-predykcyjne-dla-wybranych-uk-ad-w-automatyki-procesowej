clear all
clc;
load('aeroTF.mat');

stopTime = 50964-0.5;
aeroTF(:, 2) = aeroTF;
aeroTF(:, 1) = 0:0.5:stopTime;
%% załadowanie wykresów rzeczywistych
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
end


%% model + porównanie
TkLa = 5;
T0 = 27;
OUR = 0.00006;
Sosat = 2.375;
So0 = 2.215;

simout = sim('Model_Simulink.mdl');

% plot:
figure(1);
clf(1);
% górny wykres:
subplot(2,1,1);
plot(simout.tout, simout.So, '--', 'linewidth', 1, 'color', 'blue');
hold on;
plot(simout.tout, o2Level, 'lineWidth', 1.2, 'color', 'black'); 
xlabel('t [s]'); ylabel('Odpowiedź');
legend('So(t) - model', 'So(t) - rzeczywisty', 'placement', 'south');
xlim([0 stopTime]);
grid minor;

% dolny wykres:
subplot(2,1,2);
plot(simout.tout, simout.kLa, '--', 'linewidth', 1.1, 'color', 'red');
xlabel('t [s]'); ylabel('Odpowiedź');
legend('kLa(t)', 'placement', 'best');
xlim([0 stopTime]);
grid minor;