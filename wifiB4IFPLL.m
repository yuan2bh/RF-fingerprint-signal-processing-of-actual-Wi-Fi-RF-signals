%
% wifiB4IFPLL.m
%
% 设定参数调用simulink模型进行PLL.
% 输入: IF信号文件,                例如:1txt2matCut_IF.mat
% 输出: Simulink PLL后的解调基带文件,
%                                  例如:1_I.mat 1_Q.mat
%       VCO input文件              例如:1_VCOInput.mat
%       IF输入data经过BPF后        例如:1_PLLInput.mat
%
% 2009.3.31
% yhl
%

% charEncChange('matlab');

% ********* 读IF Mat文件 *************
IFSigFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut_IF.mat');
load(IFSigFileName,'IFSignalNoiseDMLPFed');

IFData=IFSignalNoiseDMLPFed;    clear IFSignalNoiseDMLPFed;
t=Ts*[0:length(IFData)-1];
tIFData=[t' IFData'];   %送给simulink模型的变量
IFDataLen=length(IFData);
clear t;

% ************** simulink PLL 模型的参数设定 ************
bbSymRate=symRate*11;       %基带速率:Symbol/sec,chips=11
RFHz=fifEst;             %RF速率:Hz; calibration是为200MHz
simuSpan=Ts*IFDataLen;

% ************** simulink 设定 *************
mysimopts=simset('Solver','ode5');
mysimots=simset(mysimopts,'FixedStep',Ts);
timespan=[0,simuSpan];

% ************* VCO 参数设定 *****************
VCOQuiescentFre=fifEst;   %VCO本征频率
VCOSensitivity=5e7;        %VCO: Hz/V 
                          % 5e7对short@20G/s OK;对short@10G/s 前部分没问题,后部分有一点问题   

% ***************** display 参数 **************
plotSpan=simuSpan*(50/100);

% ************ simulink 模型调用 ***********
%把锁定 载波存入IFCarrier.mat 与 基带解调信号存入 IFDeModulate.mat
% charEncChange('simulink');
open('wifiBPara');
sim('wifiBPara',timespan,mysimopts);
% charEncChange('matlab');
clear tout;

% ************ 从当前目录保存至数据目录,并删除当前目录中临时文件************
load('PLLInput.mat','PLLInput');
PLLInput=PLLInput(2,:); %simulink保存的时间信息丢掉
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
save(matFileName,'PLLInput');%数据保存至数据目录
clear PLLInput;
delete 'PLLInput.mat';

load('Q.mat','Q');
Q=Q(2,:); %simulink保存的时间信息丢掉
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_Q.mat');
save(matFileName,'Q');%数据保存至数据目录
clear Q;
delete 'Q.mat';

load('I.mat','I');
I=I(2,:); %simulink保存的时间信息丢掉
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
save(matFileName,'I');%数据保存至数据目录
clear I;
delete 'I.mat';

load('VCOInput.mat','VCOInput');
VCOInput=VCOInput(2,:); %simulink保存的时间信息丢掉
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
save(matFileName,'VCOInput');%数据保存至数据目录
clear VCOInput;
delete 'VCOInput.mat';

% ************ 结束 ************************
if(DEBUG==1)
    disp('Simulink End');
end




