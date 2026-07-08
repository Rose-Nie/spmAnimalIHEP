function IHEP_change_header_PET(Filesnn,Flipx,Flipy,Flipz)
%IHEP_CHANGE_HEADER_PET 此处显示有关此函数的摘要
%   此处显示详细说明

Num = size(Filesnn,1);

for i = 1:Num
    V = spm_vol(Filesnn(i,:));
    Y = spm_read_vols(V);
    disp(['Change Header of Rodent images:'  V.fname]);
    
%     matVa = V.mat;
%     Dim = V.dim;
%     if(abs(matVa(1,1))<2)
%         mattemp =[ -(abs(matVa(1,1))*2)             0                           0                       ((Dim(1)/2)*(abs(matVa(1,1))*2));...
%                                     0               abs(matVa(2,2))*2           0                       -((Dim(2)/2)*abs(matVa(2,2))*2);...
%                                     0               0                           abs(matVa(3,3))*2       -((Dim(3)/2)*abs(matVa(3,3))*2);...
%                                     0               0                           0                       1.0000];
%     else if(abs(matVa(1,1))<1)
%             mattemp =[ -(abs(matVa(1,1))*8)             0                           0                       ((Dim(1)/2)*(abs(matVa(1,1))*8));...
%                                     0               abs(matVa(2,2))*8           0                       -((Dim(2)/2)*abs(matVa(2,2))*8);...
%                                     0               0                           abs(matVa(3,3))*8      -((Dim(3)/2)*abs(matVa(3,3))*8);...
%                                     0               0                           0                       1.0000];
%         else
%         mattemp =[ -(abs(matVa(1,1)))             0                           0                       ((Dim(1)/2)*(abs(matVa(1,1))));...
%                                     0               abs(matVa(2,2))          0                       -((Dim(2)/2)*abs(matVa(2,2)));...
%                                     0               0                           abs(matVa(3,3))       -((Dim(3)/2)*abs(matVa(3,3)));...
%                                     0               0                           0                       1.0000];
%         end
%     end
    
    if Flipx
        clear Yn;
        Yn(:,:,:) = Y(end:-1:1,:,:);
        clear Y;
        Y = Yn;        
    end

    if Flipy
        clear Yn;
        Yn(:,:,:) = Y(:,end:-1:1,:);
        clear Y;
        Y = Yn;        
    end
    
    if Flipz
        clear Yn;
        Yn(:,:,:) = Y(:,:,end:-1:1);
        clear Y;
        Y = Yn;       
    end
    
    
%     V.mat = mattemp;
    V = spm_create_vol(V);
    spm_write_plane(V,Y,':');
    disp('                                          done.');
end

