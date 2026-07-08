function IHEPtwosampleTest_nanjingtaibai( ResultOutPath,Flag )
%IHEPTWOSAMPLETEST 此处显示有关此函数的摘要
%   此处显示详细说明
% GroupName = {'FC01';'FI01';'FSD01';'FSI01';...
%              'FC02';'FI02';'FSD02';'FSI02';...
%              'FC03';'FI03';'FSD03';'FSI03';...
%              'MC01';'MI01';'MSD01';'MSI01';...
%              'MC02';'MI02';'MSD02';'MSI02';...
%              'MC03';'MI03';'MSD03';'MSI03'};
% for subjnum = 1:1000
%     P = spm_select(Inf, 'image', ['Select group' num2str(subjnum) 'files'],{},pwd,'^s.*');
%     if isempty(P), break; end;
%     subj(subjnum).file = P; 
%     subj(subjnum).group = cell2mat(GroupName(subjnum));
% end
load('G:\BOLD\Results\fALFF.mat');
% 建模分析
subj_nums = length(subj);
if subj_nums > 1
%    for Gloop = 1:4:24
%        x = Gloop:(Gloop+3);
%        n = combntns(x,2);
%     for i = 1:6
%         file_group1 = subj(n(i,1)).file;
%         [x_group1 y_group1] = size(file_group1);
%         file_group1_n = zeros(x_group1,(y_group1+2));
%         file_group1_n = char(file_group1_n);
%         name_group1 = subj(n(i,1)).group;
%         
%         file_group2 = subj(n(i,2)).file;
%         [x_group2 y_group2] = size(file_group2);
%         file_group2_n = zeros(x_group2,(y_group2+2));
%         file_group2_n = char(file_group2_n);
%         name_group2 = subj(n(i,2)).group;
%         
%         for j = 1:size(file_group1,1)
%             [path,name,ext] = fileparts(file_group1(j,:));
%             imgname_temp = strcat(path,'\',name,ext);
%             m_temp = size(imgname_temp,2);
%             file_group1_n(j,1:m_temp) = imgname_temp;
%             clear imgname_temp;
%             clear m_temp;
%         end
%         
%         for k = 1:size(file_group2,1)
%             [path,name,ext] = fileparts(file_group2(k,:));
%             imgname_temp = strcat(path,'\',name,ext);
%             m_temp = size(imgname_temp,2);
%             file_group2_n(k,1:m_temp) = imgname_temp;
%             clear imgname_temp;
%             clear m_temp;
%         end
%         
%         if(Flag == 2)
%             IHEPtwosample_nostandard(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
% %             IHEPtwosample_standard_pairs(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
%         else if(Flag == 1)
%                 IHEPtwosample_standard(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
%             end
%         end
%     end
%    end
   
   for Gloop = 1:8
       x = [1 5 9; 2 6 10; 3 7 11; 4 8 12; 13 17 21; 14 18 22; 15 19 23; 16 20 24];
       n = combntns(x(Gloop,:),2);
    for i = 1:3
        file_group1 = subj(n(i,1)).file;
        [x_group1 y_group1] = size(file_group1);
        file_group1_n = zeros(x_group1,(y_group1+2));
        file_group1_n = char(file_group1_n);
        name_group1 = subj(n(i,1)).group;
        
        file_group2 = subj(n(i,2)).file;
        [x_group2 y_group2] = size(file_group2);
        file_group2_n = zeros(x_group2,(y_group2+2));
        file_group2_n = char(file_group2_n);
        name_group2 = subj(n(i,2)).group;
        
        for j = 1:size(file_group1,1)
            [path,name,ext] = fileparts(file_group1(j,:));
            imgname_temp = strcat(path,'\',name,ext);
            m_temp = size(imgname_temp,2);
            file_group1_n(j,1:m_temp) = imgname_temp;
            clear imgname_temp;
            clear m_temp;
        end
        
        for k = 1:size(file_group2,1)
            [path,name,ext] = fileparts(file_group2(k,:));
            imgname_temp = strcat(path,'\',name,ext);
            m_temp = size(imgname_temp,2);
            file_group2_n(k,1:m_temp) = imgname_temp;
            clear imgname_temp;
            clear m_temp;
        end
        
        if(Flag == 2)
%             IHEPtwosample_nostandard(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
            IHEPtwosample_standard_pairs(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
        else if(Flag == 1)
                IHEPtwosample_standard(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
            end
        end
    end
   end
end
end



