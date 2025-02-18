% WiFiB1txt2mat.m    
% Ŀ��:����802.11b Wlan�ڵ㷢�����Ƶ�źţ������������
%       ��ʾ�����ɼ���txt�ļ�д��mat�ļ��������������.����ÿ�ζ����ļ�.
%       (1)���ļ�:txtNum.txt 
%       (2)������txt�ļ���Ŀ¼��:*.mat 
%
%

% ******* ��ʾ������txt�ļ�����mat�ļ� *******
%�޲�ֵ�����ļ�·��������:
RFFFileNameTxt=strcat(RFFFileNameInit,'newDlink',int2str(txtNum),'.txt');

%���ļ�
fid = fopen(RFFFileNameTxt);
if(DEBUG==1)
    if(fid==-1)
        disp('open file failure');
        return
    else
        disp(strcat(RFFFileNameTxt,' file opened'));
    end
end

TESTTXTCONT=0;      %�����ļ���ʼ�����ֹ���,��������Ȳ���һ��,����switch

dataStartNumber=625;  %dlink1,speedtouch3����+1

fseek(fid, dataStartNumber, 'bof');     
if(TESTTXTCONT==1)
    DataType = '%s';    %���ַ���������������
else
    DataType = '%f64%*n';
end
RFFData = textscan(fid, DataType);
RFFDat=RFFData{1};     %�ı�����

fclose(fid);
if(TESTTXTCONT==1)
    RFFDat(1:10)
    return;     %��ȥ��txt�ļ��Ա�һ��.         
end;

if(DEBUG==1)
    t=Ts*[0:length(RFFDat)-1];
    figure;plot(t*1e6,RFFDat);title(strcat(RFFFileNameTxt,' file opened'));xlabel('usec');grid on;
end

%���浽�����ļ�
txt2matFileName=strcat(RFFFileNameInit,int2str(txtNum),'txt2mat.mat');
save(txt2matFileName,'RFFDat');
if(DEBUG==0)
    clear('RFFDat');
end

if(DEBUG==1)
    disp(strcat(num2str(txtNum),'.txt to  *.mat file OK'));
end


