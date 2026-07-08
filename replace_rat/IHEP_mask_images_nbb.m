function IHEP_mask_images_nbb( Files )
%IHEP_MASK_IMAGES_NBB �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Fullpath = fullfile(spm('Dir'),'toolbox', 'spmanimalIHEP','replace_rat','canonical','fsingle_ratbrain.nii');
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

