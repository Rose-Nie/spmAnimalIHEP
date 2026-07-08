function IHEP_change_header(Filesnn,Regsnn,Flipx,Flipy,Flipz)
%IHEP_CHANGE_HEADER 此处显示有关此函数的摘要
%   此处显示详细说明
Num = size(Regsnn,1);

for i = 1:Num
    VR = spm_vol(Filesnn(i,:));
    YR = spm_read_vols(VR);
    V = spm_vol(Regsnn(i,:));
    Y = spm_read_vols(V);
    disp(['Change Header of Rodent images:'  VR(1).fname]);
    
%     matVa = V.mat;
%     Dim = V.dim;
%     if(abs(matVa(1,1))<0.5)
%         mattemp =[ -(abs(matVa(1,1))*5)             0                           0                       ((Dim(1)/2)*(abs(matVa(1,1))*5));...
%                                     0               abs(matVa(2,2))*5           0                       -((Dim(2)/2)*abs(matVa(2,2))*5);...
%                                     0               0                           abs(matVa(3,3))*5       -((Dim(3)/2)*abs(matVa(3,3))*5);...
%                                     0               0                           0                       1.0000];
%     else
%         mattemp =[ -(abs(matVa(1,1)))             0                           0                       ((Dim(1)/2)*(abs(matVa(1,1))));...
%                                     0               abs(matVa(2,2))          0                       -((Dim(2)/2)*abs(matVa(2,2)));...
%                                     0               0                           abs(matVa(3,3))       -((Dim(3)/2)*abs(matVa(3,3)));...
%                                     0               0                           0                       1.0000];
%     end
    
    if Flipx
        clear YRn;
        clear Yn;
        for j = 1:length(VR)
            clear tempimage;
            tempimage = YR(end:-1:1,:,:,j);
            YRn(:,:,:,j) = tempimage;            
        end
        Yn(:,:,:) = Y(end:-1:1,:,:);
        clear YR;
        clear Y;
        YR = YRn;
        Y = Yn;        
    end

    if Flipy
        clear YRn;
        clear Yn;
        for j = 1:length(VR)
            clear tempimage;
            tempimage = YR(:,end:-1:1,:,j);
            YRn(:,:,:,j) = tempimage;            
        end
        Yn(:,:,:) = Y(:,end:-1:1,:);
        clear YR;
        clear Y;
        YR = YRn;
        Y = Yn;        
    end
    
    if Flipz
        clear YRn;
        clear Yn;
        for j = 1:length(VR)
            clear tempimage;
            tempimage = YR(:,:,end:-1:1,j);
            YRn(:,:,:,j) = tempimage;
        end
        Yn(:,:,:) = Y(:,:,end:-1:1);
        clear YR;
        clear Y;
        YR = YRn;
        Y = Yn;       
    end
    
    
%     V.mat = mattemp;
%     for j = 1:length(VR)
%         VR(j).mat = mattemp;
%     end
    V = spm_create_vol(V);
    VR = spm_create_vol(VR);
    spm_write_plane(V,Y,':');
    for j = 1:length(VR)
        spm_write_plane(VR(j),YR(:,:,:,j),':');
    end   
    disp('                                          done.');
end

