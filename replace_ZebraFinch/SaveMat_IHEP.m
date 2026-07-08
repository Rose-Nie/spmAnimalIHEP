File = spm_select(Inf,'nii$');
n = size(File,1);
for i = 1:n
   V = spm_vol(File(i,:));
   Y = spm_read_vols(V);
   
   [~,Name,~] = fileparts(V.fname);
   ROI(i).name = Name;
   ROI(i).temp = find(Y>0.5);
end

save('ROI.mat','ROI');