close all;
clear all;
load('skok_5L_40proc.mat');

time = 1:1:length(data);
time = time';
time = time * 0.3;
heaterOUT = data(:,2);
plot(time, heaterOUT);