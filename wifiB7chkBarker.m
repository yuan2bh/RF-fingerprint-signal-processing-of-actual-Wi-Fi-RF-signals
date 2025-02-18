% 
% wifiB7chkBarker.m
% 
% 1) ����VCOInput��ȡ������VCOCarrier�ź�;
% 2) ���ݽ�ȡ��VCOCarrier�źų��Ƚ�ȡ����RFF˲̬���ֵ�ͬ�������ź�;
% 3) ��������VCOCarrier x RFF˲̬���� -> LPF,�õ�����ź�;
% 4) ����Barker��search
% ����:���뷨��������.1)2)3)��õ��Ľ���ź�����Ƶƫ!ԭ����PLL�Ƕ�̬��.
%      �����������Ƶ�ǰ����,ȴ��һ���ܹ�Ƶ��һ��.����"˲̬ʱ����Ƶƫ��".
% ���Իص�ԭ����:����PLL���,����������ĺ������������˹�ȷ��˲̬���ֵ�barker�����ȷ��barker�����.
%
% 2009.3.31
% yhl
% ��һ�����������Ǳ����������.
% scruPLLInput:δ��ʱ;
% scruVCOInput:�˹�ͬ����ʱ��;
% scruI:I·����ź�,�˹���ʱ��
% scruT:�˹���ʱ��
% 

% ************************** ���� ****************************
bitRate=symRate*chipRate;   

bitSamples=fix(fs/bitRate); %һ��bit��������,ӦΪ����;

% *************** ����ͬ��:�²��� ****************
%  phaseUsec=0.0;      %usec,������ɫ������λ��
 phaseUsec=0.09;      %usec,��ͼ�п�����ǰ��
phasePnt=fix(phaseUsec*1e-6/Ts)   	%��Ӧ������

tSymbol=downsample(scruT,bitSamples,phasePnt);
ISymbol=downsample(scruI,bitSamples,phasePnt);

% ************************* ��ʾ ***************
figure; 
% % ****** ��ͣ,�˹����Ƿ� ��λ�෴? �����,����� *************
% ISymbol=ISymbol * (1);
% ��λ�෴,��ֽ����õ�ǰ�����һ�����Ƿ��ֽ��н���,��λģ��Ҳû��ϵ.

subplot(311);
plot(scruT,scruPLLInput,'k',scruT,scruI,'r');
hold on;
stem(tSymbol,ISymbol);
% title('scruPLLInput��scruI����źż�����ͬ������,��������λ�������ڳ�����*(-1)');
hold off;
xlabel('time');ylabel('��ֵ');

subplot(312);
plot(scruT,scruVCOInput);
xlabel('t/usec');
title('VCOInput���������ź�һ���ƶ�ͬ��');

% ************ ��barker code : 10110 111 000 ! �����˴���*********
ISymbol01=ISymbol>0.05;        %ת��Ϊ0,1��

[RFFDataDeBarker,headFound,headNum]=deBarker(ISymbol01,chipRate);

% ************ display ***************
subplot(313);stem(RFFDataDeBarker);
title('barker�����ֵ,�����+3��-3���ǽ�barker�������!  ������λ�෴!')

% *************** ���в�ֽ��� *****************
RFFDataDeBarker01=not(RFFDataDeBarker>0.0);  %DBPSK���,��׼Ӧ��not
RFFDataDeBarker01Decode=diffdecodevecYHL(RFFDataDeBarker01);   %Ӧ�뷢����������ֵ��ͬ

% *************** �����preamble����� *******************
%���ڲ���ȷ���Ƿ���;��һ��.
LONGPRE=1;

if(LONGPRE==1)
    load('longPreambler.mat','preambleTxOrig');%��matlab path��
    disp('longPreambler');
else
    load('shortPreambler.mat','preambleTxOrig');
    disp('shortPreambler');    
end
preambleTx=preambleTxOrig(1:length(RFFDataDeBarker01Decode));

% *************** ��ʾ,�Ա� **********************
figure;
subplot(411);stem(RFFDataDeBarker);title('���ջ���Barker��');
subplot(412);stem(RFFDataDeBarker01);title('���ջ�DBPSK�����');

subplot(413);stem(RFFDataDeBarker01Decode);title('���ջ���Barker��+��ֽ����');
subplot(414);stem(preambleTx);title('���������preamble=�����,�ȶԻ�׼,�Ե�����bits');

% **************** end ************
disp('end');
return;
