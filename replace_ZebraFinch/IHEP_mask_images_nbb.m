function IHEP_mask_images_nbb( Files )
%IHEP_MASK_IMAGES_NBB 此处显示有关此函数的摘要
%   此处显示详细说明
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_ZebraFinch','canonical','ZebraFinchMaskMIP.nii');
Y = spm_read_vols(spm_vol(Fullpath));
temp = find(Y<0.5);
n = size(Files,1);

for i = 1:n
    disp(['Extract brain from sw.. images ....:'  Files(i,:)]);
    V = spm_vol(Files(i,:));
    for j = 1:length(V)
        Ytemp = spm_read_vols(V(j));
        Ytemp(temp) = 0;
        [path,name,ext] = fileparts(V(j).fname);
        V(j).fname = strcat(path,filesep,'Brain',name,ext);
        V(j) = spm_create_vol(V(j));
        spm_write_plane(V(j),Ytemp,':');
        clear Ytemp;
    end
    disp('                                          done.');
end

end

