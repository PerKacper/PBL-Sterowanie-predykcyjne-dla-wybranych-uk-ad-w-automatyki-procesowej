clear all; close all;
P = [20 40 60 80 100];
%% 1 l:
Fin1 = [1 1 1 1 1];
Tout1 = [49 nan nan nan nan];
figure(1)
hold on;
plot3(P, Fin1, Tout1, 'o', 'color', 'red');
%% 1.5 l:
Fin2 = [1.5 1.5 1.5 1.5 1.5];  
Tout2 = [37.2 59.5 80 nan nan];
figure(1)
hold on;
plot3(P, Fin2, Tout2, 'o', 'color', 'red');
%% 2 l:
Fin3 = [2 2 2 2 2];
Tout3 = [31.7 49.1 65.9 80 nan];
figure(1)
hold on;
plot3(P, Fin3, Tout3, 'o', 'color', 'red');
%% 2.5 l:
Fin4 = [2.5 2.5 2.5 2.5 2.5];
Tout4 = [28.6 42.1 56 69.4 nan];
figure(1)
hold on;
plot3(P, Fin4, Tout4, 'o', 'color', 'red');
%% 3 l:
Fin5 = [3 3 3 3 3];
Tout5 = [26 37.7 49.2 60.7 71.7];
figure(1)
hold on;
plot3(P, Fin5, Tout5, 'o', 'color', 'red');
%% 3.5 l:
Fin6 = [3.5 3.5 3.5 3.5 3.5];
Tout6 = [24.2 34.4 44.2 54 63.4];
figure(1)
hold on;
plot3(P, Fin6, Tout6, 'o', 'color', 'red');
%% 4 l:
Fin7 = [4 4 4 4 4];
Tout7 = [22.7 31.7 40.5 49 57.8];
figure(1)
hold on;
plot3(P, Fin7, Tout7, 'o', 'color', 'red');
%% 4.5 l:
Fin8 = [4.5 4.5 4.5 4.5 4.5];
Tout8 = [21.8 29.9 37.6 45.5 53.1];
figure(1)
hold on;
plot3(P, Fin8, Tout8, 'o', 'color', 'red');
%% 5 l:
Fin9 = [5 5 5 5 5];
Tout9 = [20.9 28.3 35.5 42.5 49.4];
figure(1)
hold on;
plot3(P, Fin9, Tout9, 'o', 'color', 'red');

%% PREP:
close all;
Fin = [Fin1  Fin2  Fin3  Fin4  Fin5  Fin6  Fin7  Fin8  Fin9]';
Tout = [Tout1  Tout2  Tout3  Tout4  Tout5  Tout6  Tout7  Tout8  Tout9]'; 
% for i = 1:1:length(Tout)
%     if isnan(Tout(i))
%         Tout(i) = 80;
%     end
% end
Pow = [P P P P P P P P P]';
figure (1);
plot3(Pow, Fin, Tout,'r*');


%% FINITO
xlabel("Moc grzałki P");
ylabel("Flow input");
zlabel("Tout");
grid minor;
hold off;

%% Chka stat:
openfig('Chka_stat_model.fig');


