function IHEP_save_suvrImages( Files,FlagSUVRreference )
%IHEP_SAVE_SUVRIMAGES 此处显示有关此函数的摘要
%   此处显示详细说明
load('ROISUVR.mat');
n = size(Files,1);
for i = 1:n
    disp(['Save SUVR images from Brain.. images ....:'  Files(i,:)]);
    
    V = spm_vol(Files(i,:));
    Y = spm_read_vols(V);    
    MeanV = mean(Y(ROISUVR(FlagSUVRreference).temp));    
    Yn = Y / MeanV;
    [path,name,ext] = fileparts(V.fname);
    V.fname = strcat(path,filesep,'SUVR',name,'_',char(ROISUVR(FlagSUVRreference).name),ext);
    V.dt = [16 0];
    V = spm_create_vol(V);    
    spm_write_plane(V,Yn,':');

    disp('                                          done.');
end

end

