% 
% wifiB5IFPLLCheck.m
% 
% 检查PLL是否正确.怎样检查?
% (1) sqrt(I*I + Q*Q)后是否与PLLINput包络一致?相位?
% (2) VCOInput是否完美?
% (3) 解码是否正确?(下一个程序)
% 2009.3.31
% yhl

% % ********************************************************************
% %               个别检查,本来在第一个参数设置文件中设置 
% % ********************************************************************
% RFFFileNameInit = 'D:/2-antennaDirectConnect/shortPreamble/1-Dlink/dlink3/'
% txtNum=1

% ************* load VCOInput *********
VCOInputFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
load(VCOInputFileName,'VCOInput');

% ************** load PLLInput并归一化 **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
load(PLLInputFile,'PLLInput');
PLLInput=PLLInput/max(PLLInput);

% ************** load I Q 计算幅值并归一化 **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_Q.mat');
load(PLLInputFile,'Q');

PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
load(PLLInputFile,'I');

I2Q2Sqrt=sqrt(I.*I+Q.*Q);
I2Q2Sqrt=I2Q2Sqrt/max(I2Q2Sqrt);

IQ=I+j*Q;
IQAngle=angle(IQ);

% *************** 选择细看范围 ********************
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

%********** 为了t显示时与wifiB2CutRFF.m的结果一致 ***********
t=t+tStart*1e6;
scruT=scruT+tStart*1e6;

%********** 幅值 *********************
figure;
subplot(311);
plot(t ,VCOInput);xlabel('usec');title('VCOInput');

subplot(312);
plot(t ,PLLInput,'k',t ,I2Q2Sqrt,'r',t ,I,'b',t ,Q,'g');xlabel('usec');


title('sqrt(I*I + Q*Q)后是否与PLLINput包络对比.blue---I');
subplot(313);
plot(scruT ,scruPLLInput,'k',scruT ,scruI2Q2Sqrt,'r',scruT,scruI,'b',scruT,scruQ,'g');xlabel('usec');title('包络对比scrutinize');


%********** 相位 *********************
figure;
subplot(311);
plot(t ,IQAngle,'r');xlabel('usec');title('相位');
subplot(312);
plot(t ,PLLInput,'k',t ,IQAngle,'r');xlabel('usec');title('相位与PLLINput对比');
subplot(313);
plot(scruT ,scruPLLInput,'k',scruT ,scruIQAngle,'r');xlabel('usec');title('相位对比scrutinize');


