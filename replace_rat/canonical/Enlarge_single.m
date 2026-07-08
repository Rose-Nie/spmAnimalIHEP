
File = spm_select(Inf,'img$','');
n = size(File,1);

for i = 1:n
    V = spm_vol(File(i,:));
    Image = spm_read_vols(V);
    
    Imagenew = zeros(140,98,90);
    Imagenew(11:130,1:98,1:80) = Image;
    
    V.dim = [140 98 90];
%     V.mat = [   -1.0000         0         0   70.0000;...
%          0    1.0000         0  -41.0000;...
%          0         0    1.5000  -75.0000;...
%          0         0         0    1.0000];

    V.mat = [   -1.0000         0         0   70.0000;...
         0    1.5000         0  -75.0000;...
         0         0    1.0000  -41.0000;...
         0         0         0    1.0000];
%     
    V = spm_create_vol(V);
    
    spm_write_plane(V,Imagenew,':');
end