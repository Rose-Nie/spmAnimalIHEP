function pr_print(name)
% List of open inputs
% Print: Print Filename - cfg_entry
nrun = 1; % enter the number of runs here
jobfile_temp = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_mouse','@slover','private','pr_print_job.m');
jobfile = {jobfile_temp};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = name; % Print: Print Filename - cfg_entry
end
spm('defaults', 'PET');
spm_jobman('serial', jobs, '', inputs{:});
