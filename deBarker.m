function [deBarkCode,headFound,headNum]=deBarker(barkCode,chipRate);
% deBarker.m
% 把barker码:1  0  1  1  0  1  1  1  0  0  0 解码为+1
% 把barker码:0  1  0  0  1  0  0  0  1  1  1 解码为-1
% 输入:barkCode(0,1);
%      chipRate: barker code 长度
% 输出:deBArkCode(+1,-1),如果出现+3或-3,输入码中含不是barker码的码;
%      headFound,1--- 找到头; 0---未找到头;
%      headNum,第一个barker码序号;
% yhl
% 2009.1.13

headFound=0;    %1---第一个barker码找到
deBarkCode=[];
i=1;
iBarker=1;
headNum=-1;
while i<=(length(barkCode)-chipRate+1),
    if(headFound==0)    %找第一个barker码
%         num2str(barkCode(i:i+chipRate-1))       %显示
        if (strcmp(num2str(barkCode(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
            headFound=1;
            headNum=i;  %记录第一个barker码起始序号
            deBarkCode(iBarker)=+1;
            iBarker=iBarker+1;
            i=i+chipRate;
        elseif (strcmp(num2str(barkCode(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
                headFound=1;
                headNum=i;  %记录第一个barker码起始序号
                deBarkCode(iBarker)=-1;
                iBarker=iBarker+1;
                i=i+chipRate;            
        else
            i=i+1;
        end
    else                %译码后续的barker码
        if (barkCode(i)==1)  %比较'10110111000'
%             num2str(barkCode(i:i+chipRate-1))
            if (strcmp(num2str(barkCode(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
                deBarkCode(iBarker)=+1;
            else
                deBarkCode(iBarker)=+3;    %error flag
            end
        else    %比较 '01001000111'
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


% % headFound=0;    %1---第一个barker码找到
% % RFFDataDeBarker=[];
% % i=1;
% % iBarker=1;
% % headNum=-1;
% % while i<=(length(IFDeModulateSymbol01)-chipRate+1),
% %     if(headFound==0)    %找第一个barker码
% % %         num2str(IFDeModulateSymbol01(i:i+chipRate-1))       %显示
% %         if (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
% %             headFound=1;
% %             headNum=i;  %记录第一个barker码起始序号
% %             RFFDataDeBarker(iBarker)=+1;
% %             iBarker=iBarker+1;
% %             i=i+chipRate;
% %         elseif (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'0  1  0  0  1  0  0  0  1  1  1')==1)
% %                 headFound=1;
% %                 headNum=i;  %记录第一个barker码起始序号
% %                 RFFDataDeBarker(iBarker)=-1;
% %                 iBarker=iBarker+1;
% %                 i=i+chipRate;            
% %         else
% %             i=i+1;
% %         end
% %     else                %译码后续的barker码
% %         if (IFDeModulateSymbol01(i)==1)  %比较'10110111000'
% % %             num2str(IFDeModulateSymbol01(i:i+chipRate-1))
% %             if (strcmp(num2str(IFDeModulateSymbol01(i:i+chipRate-1)),'1  0  1  1  0  1  1  1  0  0  0')==1)
% %                 RFFDataDeBarker(iBarker)=+1;
% %             else
% %                 RFFDataDeBarker(iBarker)=+3;    %error flag
% %             end
% %         else    %比较 '01001000111'
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