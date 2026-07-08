function IHEPtwosample_standard_pairs(group1, name1, group2, name2,path_result)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Factorial design specification: Scans [1,2] - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
nrun = 1; % enter the number of runs here
jobfile = {'E:\Program Files\MATLAB\spm12\toolbox\spmAnimalIHEP\replace_mouse\IHEPtwosample_standard_pairs_job.m'};
jobs = repmat(jobfile, 1, nrun);
n = size(group1,1);
m = size(group2,1);
if(n ==m)
inputs = cell((n+3), nrun);
for crun = 1:nrun
    dir_name = strcat(path_result,'\result_',name1,'-',name2);
    mkdir(dir_name);
    contrast1 = strcat(name1,'-',name2);
    contrast2 = strcat(name2,'-',name1);
    
    inputs{1, crun} = cellstr(dir_name); % Factorial design specification: Directory - cfg_files
    for i = 1:n
        test=[cellstr(group1(i,:));cellstr(group2(i,:))];
        
        inputs{(i+1), crun} = test; % Factorial design specification: Scans [1,2] - cfg_files
    end
    
    inputs{(n+2), crun} = contrast1; % Contrast Manager: Name - cfg_entry
    inputs{(n+3), crun} = contrast2; % Contrast Manager: Name - cfg_entry
end
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
