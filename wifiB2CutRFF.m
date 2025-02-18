%
% WiFiB2CutRFF.m
%
% 读Agilent示波器得到的802.11b信号mat文件,
% 文件号:matNum;
% 人工粗看,尽量长,为了PLL.
% 截取需要部分并归一化后保存在 ?txt2matCut.mat中.
% yhl
% 2008.3.31
% 

% ************** 读文件data *******************
txt2matFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2mat.mat');
load (txt2matFileName,'RFFDat');

t=Ts*[0:length(RFFDat)-1];
figure;plot(t*1e6,RFFDat);title(txt2matFileName);xlabel('usec');

%**************** 截取部分数据 *********************
tStart=5e-6+eps;
% tEnd=Ts*length(RFFDat)/1;
tEnd=40e-6;
% tEnd=34e-6;

pntStart=ceil(tStart/Ts);pntEnd=floor(tEnd/Ts);
RFFDat=RFFDat(pntStart:pntEnd);

% ***************数据是否要归一? 相对于放大器*******************
RFFDat=RFFDat'/max(RFFDat);  %归一后还是前一部分好,后一部分坏

%保存截取后到磁盘文件
txt2matCutFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut.mat');
save(txt2matCutFileName,'RFFDat');

% 显示
t=[tStart:Ts:tEnd];
figure;
plot(t*1e6,RFFDat);
title(strcat(txt2matCutFileName,'截取需要部分并归一化 ok '));
xlabel('usec');grid on;
axis([tStart*1e6,tEnd*1e6,-1.2,1.2]);

if(DEBUG==1)
    disp(strcat(txt2matCutFileName,'截取需要部分归一化并保存至文件 ok '));
end









