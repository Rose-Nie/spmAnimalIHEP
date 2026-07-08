function IHEPtwosampleTest( ResultOutPath,Flag,FlagMask )
%IHEPTWOSAMPLETEST 此处显示有关此函数的摘要
%   此处显示详细说明
for subjnum = 1:1000
    P = spm_select(Inf, 'image', ['Select group' num2str(subjnum) 'files'],{},pwd,'^s.*');
    if isempty(P), break; end;
    subj(subjnum).file = P; 
    subj(subjnum).group = spm_input(sprintf('Name of group %d', subjnum),'+1','s');
end

% 建模分析
subj_nums = length(subj);
if subj_nums > 1
    x = 1:subj_nums;
    n = combntns(x,2);
    loop = size(n,1);
    for i = 1:loop
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
            if(FlagMask ==1)
                IHEPtwosample_nostandard_WholeBrain(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
%               IHEPtwosample_standard_pairs(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
            else
                if(FlagMask ==2)
                    IHEPtwosample_nostandard_WhiteMatter(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
                else
                    if(FlagMask ==3)
                        IHEPtwosample_nostandard_GrayMatter(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
                    end
                end
            end
        else
            if(Flag == 1)
                if(FlagMask ==1)
                IHEPtwosample_standard_WholeBrain(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
%               IHEPtwosample_standard_pairs(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
                else
                    if(FlagMask ==2)
                    IHEPtwosample_standard_WhiteMatter(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
                    else
                        if(FlagMask ==3)
                        IHEPtwosample_standard_GrayMatter(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
                        end
                    end
                end
%                 IHEPtwosample_standard(file_group1_n, name_group1, file_group2_n, name_group2,ResultOutPath);
            end
        end
    end
end
end

