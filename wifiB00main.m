% ������ڣ�run ok @ Matlab2022a 
% Ԭ���� Honglin Yuan(Nantong University)
% 2025.2.18

% 
% WiFiB00main.m
% 
% �������ò���batch����. 
% yhl
% 2009.8.22
% 
% *********************************************
%                     �����趨 
% **********************************************

clear all; clc; close all;

%*********************** ���Բ��� ***************
DEBUG=1;       %1---��ʾ�м���; 0---����м����������ʾ

% ************************* ϵͳ���� ***********************
% symRate��PLL��LPF�����й�,long��short����ͬ������û��ϵ
symRate=1e6;    %WiFib long preamble��192usec��1M DBPSK�ź�
                %WiFib short preamble��72usec��1M DBPSK�ź�+24usec��2M �ź�;����ֻ��short
chipRate=11;    %Barker����� 11chips/symbol

% ***************** ��ƵƵ�� *********
% WiFiB3IFGen.m��
fif=200e6;    %
if(DEBUG==1)
    fif
end

% ******* ʾ�������� ***************
fs=20e9;
Ts=1/fs;    %txt��������ʾ����������,Խ���Ƶ�ʹ��Ƽ�Simulink PLL����Խ��
if(DEBUG==1)
    fs
end

% **************** ����txt�ļ��ص�,����dataset�ļ�λ���ֹ����� ***************
RFFFileNameInit = './Data/'
LONGPRE=0;      % 1 --- long preamble; 0 --- short preamble
                % wifiB7chkBarker.m��ʹ��,Ӱ��ȶԵ�preamble��long����short.
if(DEBUG==1)
    LONGPRE
end            

txtNum=1         %����ĵ���mat�ļ����


wifiB1txt2mat; % from txt fiel to mat file

wifiB2CutRFF;  % cut the part of the RF signal 

wifiB3IFGen;   % geneate the IF signal
 
wifiB4IFPLL;   % soft PLL

wifiB5IFPLLCheck; % check the signal after the PLL

wifiB6Scrutinize; % scutinize the signal 

wifiB7chkBarker;  % check the Barker code


return;












