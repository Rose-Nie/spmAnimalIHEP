function  F_test_pre
%F_TEST_PRE 此处显示有关此函数的摘要
%   此处显示详细说明
ResultFiles = [{'MD'};{'AD'};{'RD'}];
for kk = 1:length(ResultFiles)
    load(strcat('G:\MOUSE\DTInii\',char(ResultFiles(kk)),'.mat'));
    path_result = strcat('G:\MOUSE\DTInii\ANOVA_results\',char(ResultFiles(kk)),'\');
    mkdir(path_result);
    
    file_group1_n = subj(1).file;
    file_group2_n = subj(2).file;
    file_group3_n = subj(3).file;
    file_group4_n = subj(4).file;
    
    F_test_batch(path_result,file_group1_n,file_group2_n,file_group3_n,file_group4_n)
end
end

