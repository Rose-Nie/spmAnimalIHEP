function  [OutputFile]= IHEPdeactive(file)
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

% file = spm_select(Inf,'nii$','   ');
m = size(file,1);

for i = 1:m
    [path,name,ext] = fileparts(file(i,:));
    V = spm_vol(file(i,:));
    img = spm_read_vols(V);
    
    imgnew = 0-img;
    FullPath = strcat(path,'\n',name,'_1',ext);
    tt = find(FullPath == 44);
    V.fname = FullPath(1:(tt-1));
    clear FullPath;
    OutputFiletemp(i,:) = cellstr(V.fname);
    V = spm_create_vol(V);
    spm_write_plane(V,imgnew,':');
    
    
%     [path,name,ext] = fileparts(file(i,:));
%     imgname = strcat(path,'\',name,ext);
%     img = spm_read_vols(spm_vol(imgname));
%     head_file=strrep(file(i,:),'.img','.hdr');
%     [DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN,DESCRIP] = spm_hread(head_file);
%     
%     imgnew = 0-img;
%     
%     SCALE = 1;
%     TYPE = 16;
%     outname = strcat(path,'\',name,'_1',ext);
%     id = fopen(outname,'w');
%     fwrite(id,imgnew,'float32');
%     d_head_file = strrep(outname,'.img','.hdr');
%     spm_hwrite(d_head_file,DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN,DESCRIP);
%     fclose all;
end
OutputFile = char(OutputFiletemp);
