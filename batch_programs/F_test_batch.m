function F_test_batch(ResultPath,Files1,Files2,Files3,Files4)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Scans - cfg_files
nrun = 1; % enter the number of runs here
jobfile = {'G:\MOUSE\DTInii\F_test_batch_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(5, nrun);
for crun = 1:nrun
    inputs{1, crun} = cellstr(ResultPath); % Factorial design specification: Directory - cfg_files
    inputs{2, crun} = cellstr(Files1); % Factorial design specification: Scans - cfg_files
    inputs{3, crun} = cellstr(Files2); % Factorial design specification: Scans - cfg_files
    inputs{4, crun} = cellstr(Files3); % Factorial design specification: Scans - cfg_files
    inputs{5, crun} = cellstr(Files4); % Factorial design specification: Scans - cfg_files
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
