function IHEPtwosample_nostandard_WholeBrain(group1, name1, group2, name2,path_result)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Group 1 scans - cfg_files
% Factorial design specification: Group 2 scans - cfg_files
% Contrast Manager: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
nrun = 1; % enter the number of runs here
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_ZebraFinch','IHEPtwosample_nostandard_WholeBrain_job.m');
jobfile = {Fullpath};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(5, nrun);
for crun = 1:nrun
    dir_name = strcat(path_result,filesep,'result_',name1,'-',name2);
    mkdir(dir_name);
    contrast1 = strcat(name1,'-',name2);
    contrast2 = strcat(name2,'-',name1);
    inputs{1, crun} = cellstr(dir_name); % Factorial design specification: Directory - cfg_files
    inputs{2, crun} = cellstr(group1); % Factorial design specification: Group 1 scans - cfg_files
    inputs{3, crun} = cellstr(group2); % Factorial design specification: Group 2 scans - cfg_files
    inputs{4, crun} = contrast1; % Contrast Manager: Name - cfg_entry
    inputs{5, crun} = contrast2; % Contrast Manager: Name - cfg_entry
end
spm('defaults', 'PET');
spm_jobman('serial', jobs, '', inputs{:});
