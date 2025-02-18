% WiFiB1txt2mat.m    
% 目的:处理802.11b Wlan节点发射的射频信号，完成以下任务
%       读示波器采集的txt文件写至mat文件供后续程序调用.避免每次都读文件.
%       (1)读文件:txtNum.txt 
%       (2)保存在txt文件的目录下:*.mat 
%
%

% ******* 从示波器的txt文件生成mat文件 *******
%无插值数据文件路径及名称:
RFFFileNameTxt=strcat(RFFFileNameInit,'newDlink',int2str(txtNum),'.txt');

%打开文件
fid = fopen(RFFFileNameTxt);
if(DEBUG==1)
    if(fid==-1)
        disp('open file failure');
        return
    else
        disp(strcat(RFFFileNameTxt,' file opened'));
    end
end

TESTTXTCONT=0;      %由于文件开始点是手工数,所以最好先测试一下,测试switch

dataStartNumber=625;  %dlink1,speedtouch3必须+1

fseek(fid, dataStartNumber, 'bof');     
if(TESTTXTCONT==1)
    DataType = '%s';    %用字符串看读到哪里了
else
    DataType = '%f64%*n';
end
RFFData = textscan(fid, DataType);
RFFDat=RFFData{1};     %改变量名

fclose(fid);
if(TESTTXTCONT==1)
    RFFDat(1:10)
    return;     %出去与txt文件对比一下.         
end;

if(DEBUG==1)
    t=Ts*[0:length(RFFDat)-1];
    figure;plot(t*1e6,RFFDat);title(strcat(RFFFileNameTxt,' file opened'));xlabel('usec');grid on;
end

%保存到磁盘文件
txt2matFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2mat.mat');
save(txt2matFileName,'RFFDat');
if(DEBUG==0)
    clear('RFFDat');
end

if(DEBUG==1)
    disp(strcat(num2str(txtNum),'.txt to  *.mat file OK'));
end


