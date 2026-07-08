function IHEPadapttoMIP(file)

% file = spm_select(Inf,'image','select the normalized images in Paxinos space...');
n = size(file,1);
for files_i = 1:n
%     ttt = find(file(files_i,:) == 44);
    V = spm_vol(file(files_i,:));
    disp(['Adapt rodent brain images to MIP:'  file(files_i,:)]);
    
    lt = length(V);
    if(lt ==1)
        img = spm_read_vols(V);
        DIM = V.dim;

        for x = 1:DIM(1)
           for y = 1:DIM(2)
              for z = 1:DIM(3)
                   imgnew(x,z,y) = img(x,y,z);
              end
           end
        end

        V.dim = [DIM(1) DIM(3) DIM(2)];
        mattemp = V.mat;
        V.mat = [mattemp(1,1) mattemp(1,2) mattemp(1,3) mattemp(1,4); ...
                mattemp(3,1) mattemp(3,3) mattemp(3,2) mattemp(3,4); ...
                mattemp(2,1) mattemp(2,3) mattemp(2,2) mattemp(2,4); ...
                mattemp(4,1) mattemp(4,2) mattemp(4,3) mattemp(4,4)];


        V = spm_create_vol(V);
        spm_write_plane(V,imgnew,':');
    else
        for k = 1:length(V)
            DIM = V(k).dim;
            image = spm_read_vols(V(k));

            for x = 1:DIM(1)
               for y = 1:DIM(2)
                  for z = 1:DIM(3)
                       imgnew(x,z,y) = image(x,y,z);
                  end
               end
            end

            V(k).dim = [DIM(1) DIM(3) DIM(2)];
            mattemp = V(k).mat;
            V(k).mat = [mattemp(1,1) mattemp(1,2) mattemp(1,3) mattemp(1,4); ...
                    mattemp(3,1) mattemp(3,3) mattemp(3,2) mattemp(3,4); ...
                    mattemp(2,1) mattemp(2,3) mattemp(2,2) mattemp(2,4); ...
                    mattemp(4,1) mattemp(4,2) mattemp(4,3) mattemp(4,4)];
            V(k) = spm_create_vol(V(k));
            spm_write_plane(V(k),imgnew,':');
            clear imgnew;
        end
    end
    
    disp('                                          done.');
end
return;