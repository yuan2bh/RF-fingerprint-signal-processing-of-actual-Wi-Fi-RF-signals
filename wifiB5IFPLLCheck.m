% 
% wifiB5IFPLLCheck.m
% 
% ���PLL�Ƿ���ȷ.�������?
% (1) sqrt(I*I + Q*Q)���Ƿ���PLLINput����һ��?��λ?
% (2) VCOInput�Ƿ�����?
% (3) �����Ƿ���ȷ?(��һ������)
% 2009.3.31
% yhl

% % ********************************************************************
% %               ������,�����ڵ�һ�����������ļ������� 
% % ********************************************************************
% RFFFileNameInit = 'D:/2-antennaDirectConnect/shortPreamble/1-Dlink/dlink3/'
% txtNum=1

% ************* load VCOInput *********
VCOInputFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
load(VCOInputFileName,'VCOInput');

% ************** load PLLInput����һ�� **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
load(PLLInputFile,'PLLInput');
PLLInput=PLLInput/max(PLLInput);

% ************** load I Q �����ֵ����һ�� **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_Q.mat');
load(PLLInputFile,'Q');

PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
load(PLLInputFile,'I');

I2Q2Sqrt=sqrt(I.*I+Q.*Q);
I2Q2Sqrt=I2Q2Sqrt/max(I2Q2Sqrt);

IQ=I+j*Q;
IQAngle=angle(IQ);

% *************** ѡ��ϸ����Χ ********************
scruStartT=eps;
scruEndT=3e-6;

scruStartPnt=ceil(scruStartT/Ts);
scruEndPnt=floor(scruEndT/Ts);

scruArange=[scruStartPnt:scruEndPnt];

scruPLLInput=PLLInput(scruArange);
scruI2Q2Sqrt=I2Q2Sqrt(scruArange);
scruI=I(scruArange);
scruQ=Q(scruArange);

scruIQAngle=IQAngle(scruArange);

% ********* display *********
t=Ts*1e6*[0:length(PLLInput)-1];    %usec
scruT=t(scruArange);

%********** Ϊ��t��ʾʱ��wifiB2CutRFF.m�Ľ��һ�� ***********
t=t+tStart*1e6;
scruT=scruT+tStart*1e6;

%********** ��ֵ *********************
figure;
subplot(311);
plot(t ,VCOInput);xlabel('usec');title('VCOInput');

subplot(312);
plot(t ,PLLInput,'k',t ,I2Q2Sqrt,'r',t ,I,'b',t ,Q,'g');xlabel('usec');


title('sqrt(I*I + Q*Q)���Ƿ���PLLINput����Ա�.blue---I');
subplot(313);
plot(scruT ,scruPLLInput,'k',scruT ,scruI2Q2Sqrt,'r',scruT,scruI,'b',scruT,scruQ,'g');xlabel('usec');title('����Ա�scrutinize');


%********** ��λ *********************
figure;
subplot(311);
plot(t ,IQAngle,'r');xlabel('usec');title('��λ');
subplot(312);
plot(t ,PLLInput,'k',t ,IQAngle,'r');xlabel('usec');title('��λ��PLLINput�Ա�');
subplot(313);
plot(scruT ,scruPLLInput,'k',scruT ,scruIQAngle,'r');xlabel('usec');title('��λ�Ա�scrutinize');


