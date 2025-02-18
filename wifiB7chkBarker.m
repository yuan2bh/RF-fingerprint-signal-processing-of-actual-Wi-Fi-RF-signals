% 
% wifiB7chkBarker.m
% 
% 1) 根据VCOInput截取锁定的VCOCarrier信号;
% 2) 根据截取的VCOCarrier信号长度截取包括RFF瞬态部分的同样长度信号;
% 3) 用锁定的VCOCarrier x RFF瞬态部分 -> LPF,得到解调信号;
% 4) 进行Barker码search
% 结论:此想法根本不行.1)2)3)后得到的解调信号明显频偏!原因是PLL是动态的.
%      后面锁定的移到前面来,却不一定能够频率一致.可能"瞬态时发生频偏了".
% 所以回到原来的:依赖PLL解调,根据锁定后的后面的码情况与人工确定瞬态部分的barker码情况确定barker码错几个.
%
% 2009.3.31
% yhl
% 上一个程序的输出是本程序的输入.
% scruPLLInput:未延时;
% scruVCOInput:人工同步延时后;
% scruI:I路解调信号,人工延时后
% scruT:人工延时后
% 

% ************************** 参数 ****************************
bitRate=symRate*chipRate;   

bitSamples=fix(fs/bitRate); %一个bit的样点数,应为奇数;

% *************** 采样同步:下采样 ****************
%  phaseUsec=0.0;      %usec,调制蓝色采样线位置
 phaseUsec=0.09;      %usec,从图中看负数前移
phasePnt=fix(phaseUsec*1e-6/Ts)   	%对应样点数

tSymbol=downsample(scruT,bitSamples,phasePnt);
ISymbol=downsample(scruI,bitSamples,phasePnt);

% ************************* 显示 ***************
figure; 
% % ****** 暂停,人工看是否 相位相反? 如果是,则改正 *************
% ISymbol=ISymbol * (1);
% 相位相反,差分解码用当前码与后一个码是否差分进行解码,相位模糊也没关系.

subplot(311);
plot(scruT,scruPLLInput,'k',scruT,scruI,'r');
hold on;
stem(tSymbol,ISymbol);
% title('scruPLLInput与scruI解调信号及符号同步样点,如样点相位反了则在程序中*(-1)');
hold off;
xlabel('time');ylabel('幅值');

subplot(312);
plot(scruT,scruVCOInput);
xlabel('t/usec');
title('VCOInput与解调基带信号一起移动同步');

% ************ 解barker code : 10110 111 000 ! 改正了错误*********
ISymbol01=ISymbol>0.05;        %转换为0,1码

[RFFDataDeBarker,headFound,headNum]=deBarker(ISymbol01,chipRate);

% ************ display ***************
subplot(313);stem(RFFDataDeBarker);
title('barker码解码值,如出现+3或-3就是解barker码错误了!  可能相位相反!')

% *************** 进行差分解码 *****************
RFFDataDeBarker01=not(RFFDataDeBarker>0.0);  %DBPSK解调,标准应加not
RFFDataDeBarker01Decode=diffdecodevecYHL(RFFDataDeBarker01);   %应与发射机的扰码后值相同

% *************** 发射机preamble扰码后 *******************
%由于不能确定是否长码;试一试.
LONGPRE=1;

if(LONGPRE==1)
    load('longPreambler.mat','preambleTxOrig');%在matlab path中
    disp('longPreambler');
else
    load('shortPreambler.mat','preambleTxOrig');
    disp('shortPreambler');    
end
preambleTx=preambleTxOrig(1:length(RFFDataDeBarker01Decode));

% *************** 显示,对比 **********************
figure;
subplot(411);stem(RFFDataDeBarker);title('接收机解Barker码');
subplot(412);stem(RFFDataDeBarker01);title('接收机DBPSK解调后');

subplot(413);stem(RFFDataDeBarker01Decode);title('接收机解Barker码+差分解码后');
subplot(414);stem(preambleTx);title('发射机发送preamble=扰码后,比对基准,吃掉几个bits');

% **************** end ************
disp('end');
return;
