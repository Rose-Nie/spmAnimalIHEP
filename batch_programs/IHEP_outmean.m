function IHEP_outmean( file )
%IHEP_OUTMEAN 此处显示有关此函数的摘要
%   此处显示详细说明
m = size(file,1);

for i = 1:m
    Vtemp = spm_vol(file(i,:));
    image = spm_read_vols(Vtemp);
    scale = Vtemp.pinfo(1);
    image = image ./ scale;
    if i == 1
        SumImage = image;
    else
        SumImage = SumImage + image;
    end
end

MeanImage = SumImage ./ m;
% MeanImage = int16(MeanImage);

V = spm_vol(file(1,:));
V.fname = 'UserDefinedMean.nii';
V.descrip = '';
V.pinfo = [1;0;0];
V = spm_create_vol(V);
spm_write_plane(V,MeanImage,':');
fclose all;

end

