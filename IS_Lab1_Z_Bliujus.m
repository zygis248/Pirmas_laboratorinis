clc;
clear;
close all;
%Perceptrono mokymas

%Obuolių paveiksliukų nuskaitymas
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

%Kriaušių paveiksliukų nuskaitymas
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

%Spalvos ir apvalumo išreiškimas skaitine verte
%Obuoliai
%1-as obuolio paveikslas(A1)
hsv_value_A1=spalva_color(A1); %spalva
metric_A1=apvalumas_roundness(A1); %apvalumas
%2-as obuolio paveikslas(A2)
hsv_value_A2=spalva_color(A2); %spalva
metric_A2=apvalumas_roundness(A2); %apvalumas
%3-ias obuolio paveikslas(A3)
hsv_value_A3=spalva_color(A3); %spalva
metric_A3=apvalumas_roundness(A3); %apvalumas
%4-tas obuolio paveikslas(A4)
hsv_value_A4=spalva_color(A4); %spalva
metric_A4=apvalumas_roundness(A4); %apvalumas
%5-tas obuolio paveikslas(A5)
hsv_value_A5=spalva_color(A5); %spalva
metric_A5=apvalumas_roundness(A5); %apvalumas
%6-tas obuolio paveikslas(A6)
hsv_value_A6=spalva_color(A6); %spalva
metric_A6=apvalumas_roundness(A6); %apvalumas
%7-tas obuolio paveikslas(A7)
hsv_value_A7=spalva_color(A7); %spalva
metric_A7=apvalumas_roundness(A7); %apvalumas
%8-tas obuolio paveikslas(A8)
hsv_value_A8=spalva_color(A8); %spalva
metric_A8=apvalumas_roundness(A8); %apvalumas
%9-tas obuolio paveikslas(A9)
hsv_value_A9=spalva_color(A9); %spalva
metric_A9=apvalumas_roundness(A9); %apvalumas

%Kriaušės
%1-as kriaušės paveikslas(P1)
hsv_value_P1=spalva_color(P1); %spalva
metric_P1=apvalumas_roundness(P1); %apvalumas
%2-as kriaušės paveikslas(P2)
hsv_value_P2=spalva_color(P2); %spalva
metric_P2=apvalumas_roundness(P2); %apvalumas
%3-ias kriaušės paveikslas(P3)
hsv_value_P3=spalva_color(P3); %spalva
metric_P3=apvalumas_roundness(P3); %apvalumas
%4-tas kriaušės paveikslas(P4)
hsv_value_P4=spalva_color(P4); %spalva
metric_P4=apvalumas_roundness(P4); %apvalumas

%mokymo algoritmas

%Suformuojama matrica 2x13 su paveikslų savybėmis: spalva ir apvalumu
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P1 hsv_value_P2 hsv_value_P3 hsv_value_P4];
x2=[metric_A1 metric_A2 metric_A3 metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P1 metric_P2 metric_P3 metric_P4];
P=[x1;x2];

%Tikrosios išėjimo vektoriaus vertės
T=[1;1;1;1;1;1;1;1;1;-1;-1;-1;-1]; % 

% perceptrono modelis - du įėjimai, vienas išėjimas
% verčių w1, w2 ir b parinkimas atsitiktiniais skaičiais tarp 0 ir 1
w1 = randn(1);
w2 = randn(1);
b = randn(1);
E = rand(1); %klaida, reikalinga pirmai while ciklo iteracijai
step = 0.05; %mokymo žingsnis
num_iter = 0; %parametras dėl įdomumo, nurodantis mokymo iteracijų skaičių
while E ~= 0 

e = 0; %Kintamasis cikle klaidos sumavimui visoms įėjimo poroms
for i = 1:length(x1)
  v1 = P(1,i)*w1+P(2,i)*w2+b; %Svorinė suma
% Perceptrono išėjimo skaičiavimas
  if v1 > 0
	y = 1;
  else
	y = -1;
  end
% Klaidos skaičiavimas ir svorių atnaujinimas
  e = e + abs(T(i) - y);
  w1 = w1 + step * (T(i) - y) * P(1,i);
  w2 = w2 + step * (T(i) - y) * P(2,i);
  b = b + step * (T(i) - y);
end
  E = e;
  num_iter = num_iter + 1;
end
%Rezultatų atnaujinimas
figure
xx2 = -w1/w2*x1 - b/w2;
plot(x1(1:9), x2(1:9), 'b*', x1(10:13), x2(10:13), 'ro', x1, xx2); grid; title('Perceptrono mokymas'); xlabel('x1'); ylabel('x2')

