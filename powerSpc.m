% 
% powerSpc.m ��ʾ�źŹ�����
% yhl 
% 2008.12.30
% 
% DEB:1---��ʾ; 0---����ʾ
%
function [Pxx,f]=powerSpc(data,fs,DEB)
[Pxx,f] = pwelch(data,[],[],length(data),fs);
Pxx=Pxx/max(Pxx);       %��һ
Pxx=10*log10(Pxx+eps); %dB��
if(DEB==1)
    figure;
    plot(f,Pxx);    
    title('�źŵĹ�����');    
    xlabel('Hz');     ylabel('dB');grid on;
end