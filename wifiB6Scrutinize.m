%
% wifiB6Scrutinize.m
% 
% ϸ��&ͬ��:Ϊ��һ���������׼��
% ����: 
% ���: (��һ������Ľ������)
% scruPLLInput:δ��ʱ;
% scruVCOInput:�˹�ͬ����ʱ��;
% scruI:I·����ź�,�˹���ʱ��
% scruT:�˹���ʱ��
% 

% ************* load VCOInput *********
VCOInputFileName=strcat(RFFFileNameInit,int2str(txtNum),'_VCOInput.mat');
load(VCOInputFileName,'VCOInput');

% ************** load PLLInput����һ�� **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_PLLInput.mat');
load(PLLInputFile,'PLLInput');
PLLInput=PLLInput/max(PLLInput);

% ************** load I  �����ֵ����һ�� **********
PLLInputFile=strcat(RFFFileNameInit,int2str(txtNum),'_I.mat');
load(PLLInputFile,'I');
I=I/max(I);

t=Ts*1e6*[1:length(I)]; %usecΪ��λ

% ***********����ͼ�ο���Ҫ������ ******************
tStart=eps*1e-6;        
tEnd=6*1e-6;           % 6 usec;  30 usec

pntStart=ceil(tStart/Ts);
pntEnd=ceil(tEnd/Ts);

% ****************** �˹���������ź�������IF�ź�ͬ�� *************
delayUsec=0.0;      %usec,��ͼ�п�; ���ƺ���λ��,��===I·ǰ��.PLLInput�����������ʱ
delayPnt=fix(delayUsec*1e-6/Ts)   	%��Ӧ������

% *************** ��ȡ��Ҫ���� **********
scruPLLInput=PLLInput(pntStart:pntEnd);   %�����ź�

scruVCOInput=VCOInput(pntStart+delayPnt:pntEnd+delayPnt);
scruI=I(pntStart+delayPnt:pntEnd+delayPnt);

scruT=t(pntStart+delayPnt:pntEnd+delayPnt);

% ***************  ��ʾ  **************
figure; 

subplot(311);
plot(t,PLLInput,'k',t,I,'r');title('δ���˹���ʱͬ����PLLInput �� I·�ź�');
subplot(312);
plot(scruT,scruPLLInput,'k',scruT,scruI,'r');title('δ��ʱ��PLLInput ����ʱ���I·�ź� ϸ��');
subplot(313);
plot(scruT,scruVCOInput);title('��ʱ���VCOInput');xlabel('t/usec');


