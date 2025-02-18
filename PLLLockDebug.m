% 
% PLLLockDebug.m
%
% 我只要保证一个网卡的所有帧是同一个环境：fc与fifEst；只有固定fc与fifEst才能保证同一个无线网卡帧样本的一致性。
% 
% PLL锁定调试：% 流程：
%   （1）先取网卡N个样本中的一个样本，取完整信号，程序估计fc，然后手工固定fc；
%   （2）取完整信号，程序估计fifEst；
%   （3) 根据程序估计的fifEst,取1/3信号,手工调试fifEst(0.1MHz步长),看是否锁定；1.取短信号PLL是否locked没关系，例如1/3，15usec；
%   （4）用得到的参数看所有N个样本是否锁定。
%    
% 
% 已经验证过的参数：
% （1）dlink1---取1/3信号，fc=2.412e9+fifEst=2.0e8;10个样本都locked；
% （2）dlink1---取1/3信号，fc=2.4129e9（程序估计的）->fifEst=1.990e8，锁定。
% 

% fc=2.4127e9     %802.11b的信道，由完整信号上面程序估计然后定下来。

fifEst=1.999e8  
fifEst=2.000e8  
fifEst=2.001e8  
fifEst=2.002e8  

fifEst=2.005e8  
fifEst=2.006e8  


wifiB4IFPLL

