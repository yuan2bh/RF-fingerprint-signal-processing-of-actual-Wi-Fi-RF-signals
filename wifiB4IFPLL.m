%
% wifiB4IFPLL.m
%
% �趨��������simulinkģ�ͽ���PLL.
% ����: IF�ź��ļ�,                ����:1txt2matCut_IF.mat
% ���: Simulink PLL��Ľ�������ļ�,
%                                  ����:1_I.mat 1_Q.mat
%       VCO input�ļ�              ����:1_VCOInput.mat
%       IF����data����BPF��        ����:1_PLLInput.mat
%
% 2009.3.31
% yhl
%

% charEncChange('matlab');

% ********* ��IF Mat�ļ� *************
IFSigFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut_IF.mat');
load(IFSigFileName,'IFSignalNoiseDMLPFed');

IFData=IFSignalNoiseDMLPFed;    clear IFSignalNoiseDMLPFed;
t=Ts*[0:length(IFData)-1];
tIFData=[t' IFData'];   %�͸�simulinkģ�͵ı���
IFDataLen=length(IFData);
clear t;

% ************** simulink PLL ģ�͵Ĳ����趨 ************
bbSymRate=symRate*11;       %��������:Symbol/sec,chips=11
RFHz=fifEst;             %RF����:Hz; calibration��Ϊ200MHz
simuSpan=Ts*IFDataLen;

% ************** simulink �趨 *************
mysimopts=simset('Solver','ode5');
mysimots=simset(mysimopts,'FixedStep',Ts);
timespan=[0,simuSpan];

% ************* VCO �����趨 *****************
VCOQuiescentFre=fifEst;   %VCO����Ƶ��
VCOSensitivity=5e7;        %VCO: Hz/V 
                          % 5e7��short@20G/s OK;��short@10G/s ǰ����û����,�󲿷���һ������   

% ***************** display ���� **************
plotSpan=simuSpan*(50/100);

% ************ simulink ģ�͵��� ***********
%������ �ز�����IFCarrier.mat �� ��������źŴ��� IFDeModulate.mat
% charEncChange('simulink');
open('wifiBPara');
sim('wifiBPara',timespan,mysimopts);
% charEncChange('matlab');
clear tout;

% ************ �ӵ�ǰĿ¼����������Ŀ¼,��ɾ����ǰĿ¼����ʱ�ļ�************
load('PLLInput.mat','PLLInput');
PLLInput=PLLInput(2,:); %simulink�����ʱ����Ϣ����
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
save(matFileName,'PLLInput');%���ݱ���������Ŀ¼
clear PLLInput;
delete 'PLLInput.mat';

load('Q.mat','Q');
Q=Q(2,:); %simulink�����ʱ����Ϣ����
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_Q.mat');
save(matFileName,'Q');%���ݱ���������Ŀ¼
clear Q;
delete 'Q.mat';

load('I.mat','I');
I=I(2,:); %simulink�����ʱ����Ϣ����
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
save(matFileName,'I');%���ݱ���������Ŀ¼
clear I;
delete 'I.mat';

load('VCOInput.mat','VCOInput');
VCOInput=VCOInput(2,:); %simulink�����ʱ����Ϣ����
matFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
save(matFileName,'VCOInput');%���ݱ���������Ŀ¼
clear VCOInput;
delete 'VCOInput.mat';

% ************ ���� ************************
if(DEBUG==1)
    disp('Simulink End');
end




