clear
close all
clc

A=[0 1 0 0;0 (-5.4/1.0731) (9.81*0.209/1.0731) 0;0 0 0 1;0 (5.4/(0.3302*1.0731)) (-9.81*(0.209+1.0731)/(0.3302*1.0731)) 0]
B=[0;1.0717/1.0731;0;-1.0717/(0.3302*1.0731)]
C=[1 0 0 0];
D=[0];

G=tf(ss(A,B,C,D))

s=tf('s');

C=9/16*(s+16)/(s+3)

%th=0.01:0.01:2*pi;
%plot(cos(th),sin(th),'--')
%hold on
%nyquistplot(C*G)
%figure (2), bode(C*G)

%% discretizar %%

[NG,DG] = tfdata(G,'v');
[NC,DC] = tfdata(C,'v');

% SOZ
Cs0 = c2d(C,0.1,'zoh')
[NCS0,DCS0] = tfdata(Cs0,'v');
Cs5 = c2d(C,0.5,'zoh')
[NCS5,DCS5] = tfdata(Cs5,'v');
Cs1 = c2d(C,1,'zoh')
[NCS1,DCS1] = tfdata(Cs1,'v');

% Tustin
Ct0 = c2d(C,0.1,'tustin')
[NCT0,DCT0] = tfdata(Ct0,'v');
Ct5 = c2d(C,0.5,'tustin')
[NCT5,DCT5] = tfdata(Ct5,'v');
Ct1 = c2d(C,1,'tustin')
[NCT1,DCT1] = tfdata(Ct1,'v');

% Mapeamento de Polos e Zeros
Cm0 = c2d(C,0.1,'matched')
[NCM0,DCM0] = tfdata(Cm0,'v');
Cm5 = c2d(C,0.5,'matched')
[NCM5,DCM5] = tfdata(Cm5,'v');
Cm1 = c2d(C,1,'matched')
[NCM1,DCM1] = tfdata(Cm1,'v');

%% projetar novo Cd %%

Go = c2d(G,1,'zoh')

z=tf('z',1);

Cd=2.4875*(z-0.001861)/(z+0.0134)
[NCD,DCD] = tfdata(Cd,'v');
