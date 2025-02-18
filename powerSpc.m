% 
% powerSpc.m 显示信号功率谱
% yhl 
% 2008.12.30
% 
% DEB:1---显示; 0---不显示
%
function [Pxx,f]=powerSpc(data,fs,DEB)
[Pxx,f] = pwelch(data,[],[],length(data),fs);
Pxx=Pxx/max(Pxx);       %归一
Pxx=10*log10(Pxx+eps); %dB化
if(DEB==1)
    figure;
    plot(f,Pxx);    
    title('信号的功率谱');    
    xlabel('Hz');     ylabel('dB');grid on;
end