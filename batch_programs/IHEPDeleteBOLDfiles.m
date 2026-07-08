function  IHEPDeleteBOLDfiles( Files,Deletenumbs_nbb )
%IHEPDELETEBOLDFILES 此处显示有关此函数的摘要
%   此处显示详细说明
% ---------------------------
% nbb 2021.06.24
% 用于删除时间序列的前几个volume
DataLength = size(Files,1);

for i = 1:DataLength
    V = spm_vol(Files(i,:));
    Y = spm_read_vols(V);
    disp(['Delete the first:' Deletenumbs_nbb  Files(i,:)  'Images .....']);
    Yn(:,:,:,:) = Y(:,:,:,(Deletenumbs_nbb+1):end);
    Vn = V(1:(end-Deletenumbs_nbb));
    [path,name,ext] = fileparts(V(1).fname);
    for j = 1:length(Vn)
        Vn(j).fname = strcat(path,filesep,'n',name,ext);
        Vn(j).private = '';
        Vn(j).n = [j 1];
    end
    Vn = spm_create_vol(Vn);
    for j = 1:length(Vn)
        spm_write_plane(Vn(j),Yn(:,:,:,j),':');
    end
    disp('                                          done.');
    clear Vn;
end
end

