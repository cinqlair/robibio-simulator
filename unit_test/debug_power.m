close all;
clear all;
clc;

%% Mes hypothèses

% Jacobienne
J = [    4      0       0       0         0 ;
         0      0       0       6         0 ;
         0      0       0       3         1  ];

% Couples articulaire (Gamma) 
Torques =  [    -1200 ; 
                480 ; 
                290  ];

% Vitesse angulaire des articulations
dqdt = [ 5; 
         -3; 
         4      ];



%% Vérification de la force calculée

% Force sur les moteurs
Forces =  [ 300 ; 0; 0;  80;   50 ]

% Je vérifie la force avec la Jacobienne, ça doit faire zéro [0;0;0]
J*Forces - Torques




%% Calcule la vitesse des moteurs
Velocities = transpose(J) * dqdt

Pu = Torques    .* dqdt
Pa = Forces     .* Velocities


%% Calcule la puissance utile
Pu_sum_abs = sum(Torques .* dqdt)

%% Calcule absorbée
Pa_sum_abs = sum(abs(Forces .* Velocities))