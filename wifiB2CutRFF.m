%
% WiFiB2CutRFF.m
%
% ��Agilentʾ�����õ���802.11b�ź�mat�ļ�,
% �ļ���:matNum;
% �˹��ֿ�,������,Ϊ��PLL.
% ��ȡ��Ҫ���ֲ���һ���󱣴��� ?txt2matCut.mat��.
% yhl
% 2008.3.31
% 

% ************** ���ļ�data *******************
txt2matFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2mat.mat');
load (txt2matFileName,'RFFDat');

t=Ts*[0:length(RFFDat)-1];
figure;plot(t*1e6,RFFDat);title(txt2matFileName);xlabel('usec');

%**************** ��ȡ�������� *********************
tStart=5e-6+eps;
% tEnd=Ts*length(RFFDat)/1;
tEnd=40e-6;
% tEnd=34e-6;

pntStart=ceil(tStart/Ts);pntEnd=floor(tEnd/Ts);
RFFDat=RFFDat(pntStart:pntEnd);

% ***************�����Ƿ�Ҫ��һ? ����ڷŴ���*******************
RFFDat=RFFDat'/max(RFFDat);  %��һ����ǰһ���ֺ�,��һ���ֻ�

%�����ȡ�󵽴����ļ�
txt2matCutFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut.mat');
save(txt2matCutFileName,'RFFDat');

% ��ʾ
t=[tStart:Ts:tEnd];
figure;
plot(t*1e6,RFFDat);
title(strcat(txt2matCutFileName,'��ȡ��Ҫ���ֲ���һ�� ok '));
xlabel('usec');grid on;
axis([tStart*1e6,tEnd*1e6,-1.2,1.2]);

if(DEBUG==1)
    disp(strcat(txt2matCutFileName,'��ȡ��Ҫ���ֹ�һ�����������ļ� ok '));
end









