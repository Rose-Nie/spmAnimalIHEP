function TreeShrew_adapt2MIP
% adapt images into MIP space and extract brain tissues
filenames = spm_select(Inf,'image','select normalised image, w*');
for n = 1:size(filenames,1)
    filename = filenames(n,:);

    V = spm_vol(filename);
    Y = spm_read_vols(V);

for x = 1 : V.dim(1)
    for y = 1 : V.dim(2)
        for z = 1 : V.dim(3)
            Y_new(x,z,y)  = Y(x,y,z);
        end
    end
end

dim_new = [V.dim(1) V.dim(3) V.dim(2)];
V.dim = dim_new;

mat_temp = V.mat;
V.mat(2,2) = mat_temp(3,3);
V.mat(3,3) = mat_temp(2,2);
V.mat(2,4) = mat_temp(3,4);
V.mat(3,4) = mat_temp(2,4);

mypath = which('spmAnimalIHEP');
[mpath mtit mext] = fileparts(mypath);
filename1 = strcat(mpath,'/replace_Treeshew/apriori/','MIP_mask.nii'); %Ñ¡Ôñmask
V1 = spm_vol(filename1);
Y_org1 = spm_read_vols(V1);
Y1=mat2gray(Y_org1);

Y_final = Y_new.*Y1;

V1 = V;
V2 = V;
[path tit ext] = fileparts(filename);
fname1 = strcat(path,'\a', tit, '.nii');
V1.fname = fname1;
V1 = spm_create_vol(V1);
spm_write_vol(V1,Y_new);

fname2 = strcat(path,'\ma', tit, '.nii');
V2.fname = fname2;
V2 = spm_create_vol(V2);
spm_write_vol(V2,Y_final);

end;
