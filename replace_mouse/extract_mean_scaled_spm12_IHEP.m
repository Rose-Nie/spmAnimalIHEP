function extract_mean_scaled_spm12_IHEP(file_res)
%EXTRACT_MEAN_SCALED Summary of this function goes here
%  Detailed explanation goes here

load('ROI.mat');
m = size(file_res,1);
tic
A = [0.0966  -0.0015   -0.0002; -0.0006  -0.1037   -0.0013; -0.000 0.0079  0.1177; -5.1441  7.1873  -9.2404];
Matrix_mouse = [105 137 80];
pathre_backup = '';

for k = 1:m
    k
    file_res(k,:)
    [pathre,namere,extre] = fileparts(file_res(k,:));
%     resultname = strcat(str_indi,file_res(k,:).name);
    V_result = spm_vol(file_res(k,:));
    resultimg = spm_read_vols(V_result);
   
    temp_resultimg = find(resultimg > 0);
    a_temp = size(temp_resultimg,1);
    if a_temp == 0
        continue;
    else
      if(isempty(pathre_backup))
            pathre_backup = pathre;
            outfile_whole = strcat(pathre,'\',namere(1:9),'_Location_file_whole','.xlsx');
            outB(1,:) =[cellstr(namere),{''},{''},{''},{''},{''}];
            countB = 1;
      else
            if(strcmp(pathre_backup,pathre))
                countB = countB + 1;
                outB(countB,:) = [cellstr(namere),{''},{''},{''},{''},{''}];
            else
                pathre_backup = pathre;
                xlswrite(outfile_whole,outB);
                clear outfile_whole;
                clear outB;
                clear countB;
                outfile_whole = strcat(pathre,'\',namere(1:9),'_Location_file_whole','.xlsx');
                outB(1,:) = [cellstr(namere),{''},{''},{''},{''},{''}];
                countB = 1;
            end
        end

             
    mattemp = V_result.mat;
    voxelsize_nbb = [abs(mattemp(1,1)) abs(mattemp(2,2)) abs(mattemp(3,3))];
    Matrix_resultimg_x = 1:voxelsize_nbb(1):Matrix_mouse(1);
    Matrix_resultimg_y = 1:voxelsize_nbb(2):Matrix_mouse(2);
    Matrix_resultimg_z = 1:voxelsize_nbb(3):Matrix_mouse(3);
    xnbb = int16(round(Matrix_resultimg_x - 0.5));
    ynbb = int16(round(Matrix_resultimg_y - 0.5));
    znbb = int16(round(Matrix_resultimg_z - 0.5));
    
        %-----------------------------
        %·ÖÀë¸÷¸öcluster
        mask_result_image = resultimg;
        mask_result_image(temp_resultimg) = 1;
        [L,n_qu] = bwlabeln(mask_result_image,26);
        %-----------------------------
    
        outfile = strcat(pathre,'\',namere,'.xlsx');
        outA(1,:) = [{'ROI'}, {'Ke'},{'MAX_T'},{'X'},{'Y'},{'Z'}];
        count = 1;
        countB = countB + 1;
        outB(countB,:) = [{'ROI'}, {'Ke'},{'MAX_T'},{'X'},{'Y'},{'Z'}];
        for i = 1:n_qu
            resultimg_temp_qu = resultimg;
            resultimg_temp_qu(find(L ~= i)) = 0;
            
            temp_qu = find(resultimg_temp_qu > 0);
            ke_qu = length(temp_qu);
            str_ke_qu = num2str(ke_qu);
            max_t_qu = max(max(max(resultimg_temp_qu)));
            strmax_qu = num2str(max_t_qu);
            Q_qu = find(resultimg_temp_qu == max_t_qu);
            [x_qu y_qu z_qu] = ind2sub(V_result.dim,Q_qu);
             cor = [xnbb(x_qu) ynbb(y_qu) znbb(z_qu)];

            matrix_qu = [cor(1)  cor(3)  cor(2)  1];
            matrix_qu = double(matrix_qu);
            paxinos_qu = matrix_qu * A;
            strx_qu = num2str(paxinos_qu(1));
            stry_qu = num2str(paxinos_qu(2));
            strz_qu = num2str(paxinos_qu(3));
            
            stri = num2str(i);
            outstr_qu = strcat('Cluster',stri);
            
%             fprintf(id,'\r\n%s\t%s\t%s\t%s\t%s\t%s\r\n',outstr_qu,str_ke_qu,strmax_qu,strx_qu,stry_qu,strz_qu);
            count = count + 1;
            outA(count,:) = [cellstr(outstr_qu),cellstr(str_ke_qu),cellstr(strmax_qu),cellstr(strx_qu),cellstr(stry_qu),cellstr(strz_qu)];
            countB = countB + 1;
            outB(countB,:) = [cellstr(outstr_qu),cellstr(str_ke_qu),cellstr(strmax_qu),cellstr(strx_qu),cellstr(stry_qu),cellstr(strz_qu)];


           for j = 1:194
%                for j = 1:1458
               roiimg = zeros(105,137,80);
                namer = ROI(j).name;
                temp1 = ROI(j).temp;
                roiimg(temp1) = 1;
%             roiname = strcat(str_roi,file_roi(j,:).name);
%             roiimg = spm_read_vols(spm_vol(roiname));
% 
%             temp1 = find(roiimg > 0);
%             roiimg(temp1) = 1;
            roiimgtemp = roiimg(xnbb,ynbb,znbb);

            testimg = roiimgtemp .* resultimg_temp_qu;
            temp = find(testimg > 0);
            if ~isempty(temp)

                ke = length(temp);
                strke = num2str(ke);
                max_t = max(max(max(testimg)));
                strmax = num2str(max_t);
                Q = find(testimg == max_t);
                [x y z] = ind2sub(V_result.dim,Q);
                cor1 = [xnbb(x) ynbb(y) znbb(z)];
                
                matrix = [cor1(1)  cor1(3)  cor1(2)  1];
                matrix = double(matrix);
                paxinos = matrix * A;
                strx = num2str(paxinos(1));
                stry = num2str(paxinos(2));
                strz = num2str(paxinos(3));
                
                count = count + 1;
                outA(count,:) = [cellstr(namer),cellstr(strke),cellstr(strmax),cellstr(strx),cellstr(stry),cellstr(strz)];
                countB = countB + 1;
                outB(countB,:) = [cellstr(namer),cellstr(strke),cellstr(strmax),cellstr(strx),cellstr(stry),cellstr(strz)];

            end
        end
        end
        xlswrite(outfile,outA);
        clear outfile;
        clear outA;
        clear count;
    end
        clear pathr;
        clear namer;
        clear extr;
        clear roiname;
        clear roiimg;
        clear temp;
    clear pathre;
    clear namere;
    clear resultname;
    clear resultimg;
end

xlswrite(outfile_whole,outB);
