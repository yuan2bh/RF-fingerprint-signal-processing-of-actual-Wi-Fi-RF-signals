%
% WiFiB3IFGen.m
% 
% 下变频生成IF信号,保存在 ?txt2matCut_IF.mat文件
%
% yhl
% 2008.3.31
% 

%***************load截取后到磁盘文件**************
txt2matCutFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut.mat');
load(txt2matCutFileName,'RFFDat');

% %**************** 估计射频信号频率 **************
% [Pxx,f]=powerSpc(RFFDat,fs,DEBUG);
% [maxY,maxYx,xx,yy]=scruMaxVNum(f,Pxx,eps,2.4e9*2); %设定范围不能与最大值相同    
% fc=maxYx;   %估计的频率
% if(DEBUG==1)
%     fc
% end



% % change：不进行自动频率估计，固定fc
% %  fc=2.412e9     %802.11b的信道1    %dlink1有效
fc=2.4114e+009     %802.11b的信道，由完整信号上面程序估计然后定下来。

% ********************下变频 ********************
f2=fc-fif;        %产生中频频率   
t=Ts*[0:length(RFFDat)-1];
IFSignalNoiseDM=RFFDat .* cos(2*pi*f2.*t);
if(DEBUG==1)
    powerSpc(IFSignalNoiseDM,fs,DEBUG);title('powerSpc(IFSignalNoiseDM,fs)');
end

% **************** LPF 取中频信号 ***************
fp=fif*5;           %宽带
wp=(2*pi*fp/fs)/pi;     %单位为pi
lpfN=48;
b=fir1(lpfN,wp);

[db,mag,pha,grd,w] = freqz_m(b,[1]);
if(DEBUG==1)
    figure;
    subplot(211);plot(w*fs/(2*pi),db);grid on;
    subplot(212);plot(w*fs/(2*pi),pha);grid on;
end
IFSignalNoiseDMLPFed=filter(b,[1],IFSignalNoiseDM); %产生相移
IFSignalNoiseDMLPFed=2*IFSignalNoiseDMLPFed;

% %************* 中频信号功率谱估计 *************
% [Pxx,f]=powerSpc(IFSignalNoiseDMLPFed,fs,DEBUG);
% [maxY,maxYx,xx,yy]=scruMaxVNum(f,Pxx,eps,fif*2); %设定范围不能与最大值相同    
% fifEst=maxYx;   %估计的频率
% if(DEBUG==1)
%     fifEst
% end



% %**********change,固定fifEst **************
%    fifEst=1.9997e+008   %dlink1， 完整信号上面程序估计而来，调试的基准
fifEst=2.006e8 ;%采用1/3信号手工调试PLL而来。

fifDeta=fif-fifEst;
if(DEBUG==1)
    fifDeta
end

% ************** 显示 **********
if(DEBUG==1)
    figure;
    plot(t,IFSignalNoiseDMLPFed);grid on;title(' plot(t,IFSignalNoiseDMLPFed)');
end

%************** 保存到磁盘文件 ***********
IFSigFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut_IF.mat');
save(IFSigFileName,'IFSignalNoiseDMLPFed');

if(DEBUG==0)
    clear RFFDat RFFData;
    clear IFSignalNoiseDM IFSignalNoiseDMLPFed;
    clear Pxx f db grd mag pha w b;
    clear t xx yy;
end








