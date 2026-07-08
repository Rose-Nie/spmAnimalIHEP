function Cut_Brain
%CUT_BRAIN 此处显示有关此函数的摘要
%   此处显示详细说明
File = spm_select(1,'nii$','Select the image to cut ...');
V = spm_vol(File);
Y = spm_read_vols(V);

Y(:,:,109:137) = 0; %%% xiugai
%Y(:,:,1:9) = 0; 

[path,name,ext] = fileparts(V.fname);
V.fname = strcat(path,'\NbbCut_',name,ext);% .输出的文件名加前缀

V = spm_create_vol(V);
spm_write_plane(V,Y,':');
end

