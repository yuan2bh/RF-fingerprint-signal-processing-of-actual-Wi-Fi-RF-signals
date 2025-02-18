%
% wifiB6Scrutinize.m
% 
% 细看&同步:为下一个程序解码准备
% 输入: 
% 输出: (下一个程序的解码对象)
% scruPLLInput:未延时;
% scruVCOInput:人工同步延时后;
% scruI:I路解调信号,人工延时后
% scruT:人工延时后
% 

% ************* load VCOInput *********
VCOInputFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
load(VCOInputFileName,'VCOInput');

% ************** load PLLInput并归一化 **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
load(PLLInputFile,'PLLInput');
PLLInput=PLLInput/max(PLLInput);

% ************** load I  计算幅值并归一化 **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
load(PLLInputFile,'I');
I=I/max(I);

t=Ts*1e6*[1:length(I)]; %usec为单位

% ***********根据图形看需要处理部分 ******************
tStart=eps*1e-6;        
tEnd=6*1e-6;           % 6 usec;  30 usec

pntStart=ceil(tStart/Ts);
pntEnd=ceil(tEnd/Ts);

% ****************** 人工解调基带信号与输入IF信号同步 *************
delayUsec=0.0;      %usec,从图中看; 调制红线位置,正===I路前移.PLLInput经处理后有延时
delayPnt=fix(delayUsec*1e-6/Ts)   	%对应样点数

% *************** 截取需要部分 **********
scruPLLInput=PLLInput(pntStart:pntEnd);   %输入信号

scruVCOInput=VCOInput(pntStart+delayPnt:pntEnd+delayPnt);
scruI=I(pntStart+delayPnt:pntEnd+delayPnt);

scruT=t(pntStart+delayPnt:pntEnd+delayPnt);

% ***************  显示  **************
figure; 

subplot(311);
plot(t,PLLInput,'k',t,I,'r');title('未做人工延时同步的PLLInput 与 I路信号');
subplot(312);
plot(scruT,scruPLLInput,'k',scruT,scruI,'r');title('未延时的PLLInput 与延时后的I路信号 细看');
subplot(313);
plot(scruT,scruVCOInput);title('延时后的VCOInput');xlabel('t/usec');


