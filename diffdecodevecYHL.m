% 
% % diffdecodevecYHL.m
% 

% % This is Differential Decoding function

% % INPUT/OUTPUT
% % vi: differentially encode input vector
% % vo: decoded ouput vecor

% % See also diffencodevec.m

function vo=diffdecodevec(vi)
[r c]=size(vi);

if r>1 && c>1
    error('input must be a vector');
end

vo=[];
if length(vi)==0
    return
end

% vo(1)=vi(1);

for k=1:length(vi)-1
%      vo(k)=not(xor(vi(k),vi(k+1)));  %原理上:差分编码时多发送第一个码;解码时当前码与后一个码"同或",少一个码
     vo(k)=xor(vi(k),vi(k+1));  %实际上这个正确:差分编码时多发送第一个码;解码时当前码与后一个码"同或",少一个码
end

if c==1 %vi row vector
    vo=vo'; %convert output to same type of vector
end

% %
% -------------------------------------------------------------------------
% % This program or any other program(s) supplied with it does not provide any
% % warranty direct or implied. This program is free to use/share for
% % non-commercial purpose only, for any other usage contact with author.
% % @ Copyright M Khan
% % Email: mak2000sw@yahoo.com
% % http://www.geocities.com/mak2000sw
