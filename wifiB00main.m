% 程序入口，run ok @ Matlab2022a 
% 袁红林 Honglin Yuan(Nantong University)
% 2025.2.18

% 
% WiFiB00main.m
% 
% 参数设置并且batch处理. 
% yhl
% 2009.8.22
% 
% *********************************************
%                     参数设定 
% **********************************************

clear all; clc; close all;

%*********************** 调试参数 ***************
DEBUG=1;       %1---显示中间结果; 0---清除中间变量及不显示

% ************************* 系统参数 ***********************
% symRate与PLL的LPF带宽有关,long与short采用同样参数没关系
symRate=1e6;    %WiFib long preamble有192usec的1M DBPSK信号
                %WiFib short preamble有72usec的1M DBPSK信号+24usec的2M 信号;这里只用short
chipRate=11;    %Barker码调制 11chips/symbol

% ***************** 中频频率 *********
% WiFiB3IFGen.m用
fif=200e6;    %
if(DEBUG==1)
    fif
end

% ******* 示波器参数 ***************
fs=20e9;
Ts=1/fs;    %txt数据所用示波器采样率,越大对频率估计及Simulink PLL性能越好
if(DEBUG==1)
    fs
end

% **************** 处理txt文件地点,根据dataset文件位置手工设置 ***************
RFFFileNameInit = './Data/'
LONGPRE=0;      % 1 --- long preamble; 0 --- short preamble
                % wifiB7chkBarker.m中使用,影响比对的preamble是long还是short.
if(DEBUG==1)
    LONGPRE
end            

txtNum=1         %处理的单个mat文件序号


wifiB1txt2mat; % from txt fiel to mat file

wifiB2CutRFF;  % cut the part of the RF signal 

wifiB3IFGen;   % geneate the IF signal
 
wifiB4IFPLL;   % soft PLL

wifiB5IFPLLCheck; % check the signal after the PLL

wifiB6Scrutinize; % scutinize the signal 

wifiB7chkBarker;  % check the Barker code


return;












