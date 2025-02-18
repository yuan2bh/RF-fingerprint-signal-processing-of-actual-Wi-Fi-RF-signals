function [deBarkCode,headFound,headNum]=deBarker(barkCode,chipRate);
% deBarker.m
% ��barker��:1  0  1  1  0  1  1  1  0  0  0 ����Ϊ+1
% ��barker��:0  1  0  0  1  0  0  0  1  1  1 ����Ϊ-1
% ����:barkCode(0,1);
%      chipRate: barker code ����
% ���:deBArkCode(+1,-1),�������+3��-3,�������к�����barker�����;
%      headFound,1--- �ҵ�ͷ; 0---δ�ҵ�ͷ;
%      headNum,��һ��barker�����;
% yhl
% 2009.1.13

headFound=0;    %1---��һ��barker���ҵ�
deBarkCode=[];
i=1;
iBarker=1;
headNum=-1;
while i<=(length(barkCode)-chipRate+1),
    if(headFound==0)    %�ҵ�һ��barker��
%         num2str(barkCode(i:i+chipRate-1))       %��ʾ
        if (strcmp(num2str(barkCode(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
            headFound=1;
            headNum=i;  %��¼��һ��barker����ʼ���
            deBarkCode(iBarker)=+1;
            iBarker=iBarker+1;
            i=i+chipRate;
        elseif (strcmp(num2str(barkCode(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
                headFound=1;
                headNum=i;  %��¼��һ��barker����ʼ���
                deBarkCode(iBarker)=-1;
                iBarker=iBarker+1;
                i=i+chipRate;            
        else
            i=i+1;
        end
    else                %���������barker��
        if (barkCode(i)==1)  %�Ƚ�'10110111000'
%             num2str(barkCode(i:i+chipRate-1))
            if (strcmp(num2str(barkCode(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
                deBarkCode(iBarker)=+1;
            else
                deBarkCode(iBarker)=+3;    %error flag
            end
        else    %�Ƚ� '01001000111'
%             num2str(barkCode(i:i+chipRate-1))
            if (strcmp(num2str(barkCode(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
                deBarkCode(iBarker)=-1;
            else
                deBarkCode(iBarker)=-3;    %error flag
            end
        end
        iBarker=iBarker+1;
        i=i+chipRate;
    end
end


% % headFound=0;    %1---��һ��barker���ҵ�
% % RFFDataDeBarker=[];
% % i=1;
% % iBarker=1;
% % headNum=-1;
% % while i<=(length(IFDeModulateSymbol01)-chipRate+1),
% %     if(headFound==0)    %�ҵ�һ��barker��
% % %         num2str(IFDeModulateSymbol01(i:i+chipRate-1))       %��ʾ
% %         if (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
% %             headFound=1;
% %             headNum=i;  %��¼��һ��barker����ʼ���
% %             RFFDataDeBarker(iBarker)=+1;
% %             iBarker=iBarker+1;
% %             i=i+chipRate;
% %         elseif (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
% %                 headFound=1;
% %                 headNum=i;  %��¼��һ��barker����ʼ���
% %                 RFFDataDeBarker(iBarker)=-1;
% %                 iBarker=iBarker+1;
% %                 i=i+chipRate;            
% %         else
% %             i=i+1;
% %         end
% %     else                %���������barker��
% %         if (IFDeModulateSymbol01(i)==1)  %�Ƚ�'10110111000'
% % %             num2str(IFDeModulateSymbol01(i:i+chipRate-1))
% %             if (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
% %                 RFFDataDeBarker(iBarker)=+1;
% %             else
% %                 RFFDataDeBarker(iBarker)=+3;    %error flag
% %             end
% %         else    %�Ƚ� '01001000111'
% % %             num2str(IFDeModulateSymbol01(i:i+chipRate-1))
% %             if (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
% %                 RFFDataDeBarker(iBarker)=-1;
% %             else
% %                 RFFDataDeBarker(iBarker)=-3;    %error flag
% %             end
% %         end
% %         iBarker=iBarker+1;
% %         i=i+chipRate;
% %     end
% % end