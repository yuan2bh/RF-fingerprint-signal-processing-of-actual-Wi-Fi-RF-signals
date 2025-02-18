%
% WiFiB3IFGen.m
% 
% �±�Ƶ����IF�ź�,������ ?txt2matCut_IF.mat�ļ�
%
% yhl
% 2008.3.31
% 

%***************load��ȡ�󵽴����ļ�**************
txt2matCutFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut.mat');
load(txt2matCutFileName,'RFFDat');

% %**************** ������Ƶ�ź�Ƶ�� **************
% [Pxx,f]=powerSpc(RFFDat,fs,DEBUG);
% [maxY,maxYx,xx,yy]=scruMaxVNum(f,Pxx,eps,2.4e9*2); %�趨��Χ���������ֵ��ͬ    
% fc=maxYx;   %���Ƶ�Ƶ��
% if(DEBUG==1)
%     fc
% end



% % change���������Զ�Ƶ�ʹ��ƣ��̶�fc
% %  fc=2.412e9     %802.11b���ŵ�1    %dlink1��Ч
fc=2.4114e+009     %802.11b���ŵ����������ź�����������Ȼ��������

% ********************�±�Ƶ ********************
f2=fc-fif;        %������ƵƵ��   
t=Ts*[0:length(RFFDat)-1];
IFSignalNoiseDM=RFFDat .* cos(2*pi*f2.*t);
if(DEBUG==1)
    powerSpc(IFSignalNoiseDM,fs,DEBUG);title('powerSpc(IFSignalNoiseDM,fs)');
end

% **************** LPF ȡ��Ƶ�ź� ***************
fp=fif*5;           %���
wp=(2*pi*fp/fs)/pi;     %��λΪpi
lpfN=48;
b=fir1(lpfN,wp);

[db,mag,pha,grd,w] = freqz_m(b,[1]);
if(DEBUG==1)
    figure;
    subplot(211);plot(w*fs/(2*pi),db);grid on;
    subplot(212);plot(w*fs/(2*pi),pha);grid on;
end
IFSignalNoiseDMLPFed=filter(b,[1],IFSignalNoiseDM); %��������
IFSignalNoiseDMLPFed=2*IFSignalNoiseDMLPFed;

% %************* ��Ƶ�źŹ����׹��� *************
% [Pxx,f]=powerSpc(IFSignalNoiseDMLPFed,fs,DEBUG);
% [maxY,maxYx,xx,yy]=scruMaxVNum(f,Pxx,eps,fif*2); %�趨��Χ���������ֵ��ͬ    
% fifEst=maxYx;   %���Ƶ�Ƶ��
% if(DEBUG==1)
%     fifEst
% end



% %**********change,�̶�fifEst **************
%    fifEst=1.9997e+008   %dlink1�� �����ź����������ƶ��������ԵĻ�׼
fifEst=2.006e8 ;%����1/3�ź��ֹ�����PLL������

fifDeta=fif-fifEst;
if(DEBUG==1)
    fifDeta
end

% ************** ��ʾ **********
if(DEBUG==1)
    figure;
    plot(t,IFSignalNoiseDMLPFed);grid on;title(' plot(t,IFSignalNoiseDMLPFed)');
end

%************** ���浽�����ļ� ***********
IFSigFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2matCut_IF.mat');
save(IFSigFileName,'IFSignalNoiseDMLPFed');

if(DEBUG==0)
    clear RFFDat RFFData;
    clear IFSignalNoiseDM IFSignalNoiseDMLPFed;
    clear Pxx f db grd mag pha w b;
    clear t xx yy;
end








