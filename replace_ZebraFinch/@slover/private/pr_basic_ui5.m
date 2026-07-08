function obj = pr_basic_ui5(imgs, dispf)
% GUI to request parameters for slover routine
% FORMAT obj = pr_basic_ui(imgs, dispf)
%
% GUI requests choices while accepting many defaults
%
% imgs  - string or cell array of image names to display
%         (defaults to GUI select if no arguments passed)
% dispf - optional flag: if set, displays overlay (default = 1)
%
% $Id: pr_basic_ui.m,v 1.1 2005/04/20 15:05:00 matthewbrett Exp $
 
if nargin < 1
  imgs = '';
end
if isempty(imgs)
  imgs = spm_select(Inf, 'image', 'Image(s) to display');
end
img_structure = fullfile(spm('Dir'),'toolbox', 'spmAnimalIHEP','replace_ZebraFinch','canonical','BrainZebraFinchT2TemplateMIP.nii');
if ischar(imgs)
  imgs = cellstr(imgs);
end
if nargin < 2
  dispf = 1;
end
  
spm_input('!SetNextPos', 1);


% load images
nimgs = size(imgs,1);

% process names
nchars = 20;
imgns = spm_str_manip(imgs, ['rck' num2str(nchars)]);

% Get new default object
obj = slover;

% identify image types
cscale = [];
deftype = 1;
obj.cbar = [];
if nimgs ==1
  obj.img(1).vol = spm_vol(imgs{1});
  options = {'Structural','Truecolour', ...
         'Blobs','Negative blobs','Contours'};
  % if there are SPM results in the workspace, add this option
  [XYZ Z M] = pr_get_spm_results;
  if ~isempty(XYZ)
    options = {'Structural with SPM blobs', options{:}};
  end
  itype = 'Blobs';
  imgns(1) = {sprintf('Img1 (%s)',itype)};
  [mx mn] = slover('volmaxmin', obj.img(1).vol);
    if mx == 0
      return;
  end
  cprompt = ['Colormap: ' imgns{1}];
      obj.img(1).type = 'split';
      dcmap = 'hot';
      drange = [1 mx];
      obj.img(1).prop = 1;
      obj.cbar = [obj.cbar 1];
    obj.img(1).cmap = sf_return_cmap(cprompt, dcmap);
    obj.img(1).range = drange;
  
  obj.img(2).vol = spm_vol(img_structure);
  options = {'Structural','Truecolour', ...
         'Blobs','Negative blobs','Contours'};
  % if there are SPM results in the workspace, add this option
  [XYZ Z M] = pr_get_spm_results;
  if ~isempty(XYZ)
    options = {'Structural with SPM blobs', options{:}};
  end
  itype = 'Structural';
  imgns(2) = {sprintf('Img %d (%s)',i,itype)};
  [mx mn] = slover('volmaxmin', obj.img(2).vol);
    obj.img(2).type = 'truecolour';
    obj.img(2).cmap = gray;
    obj.img(2).range = [mn mx];
    deftype = 2;
    cscale = [cscale 2];
    if strcmp(itype,'Structural with SPM blobs')
      obj = add_spm(obj);
    end
        obj.transform = 'sagittal';
        % use SPM figure window
        obj.figure = spm_figure('GetWin', 'Graphics'); 
        % slices for display
        obj = fill_defaults(obj);
        slices = obj.slices;
        obj.slices = -54:1.6:54;
        % and do the display
        if dispf, obj = paint(obj); end
        [path,name,ext] = fileparts(imgs{1});
        name_new = strcat(path,'\',name,'_sagittalB.ps');
        pr_print(name_new);
 
else if nimgs ==2  %分开显示暖色调与冷色调
        obj.img(1).vol = spm_vol(imgs{1});
        options = {'Structural','Truecolour', ...
            'Blobs','Negative blobs','Contours'};
        % if there are SPM results in the workspace, add this option
        [XYZ Z M] = pr_get_spm_results;
        if ~isempty(XYZ)
            options = {'Structural with SPM blobs', options{:}};
        end
        itype1 = 'Blobs';
        imgns(1) = {sprintf('Img1 (%s)',itype1)};
        [mx1 mn1] = slover('volmaxmin', obj.img(1).vol);
        
        obj.img(2).vol = spm_vol(imgs{2});
        options = {'Structural','Truecolour', ...
            'Blobs','Negative blobs','Contours'};
        % if there are SPM results in the workspace, add this option
        [XYZ Z M] = pr_get_spm_results;
        if ~isempty(XYZ)
            options = {'Structural with SPM blobs', options{:}};
        end
        itype2 = 'Negative blobs';
        imgns(2) = {sprintf('Img2 (%s)',itype2)};
        [mx2 mn2] = slover('volmaxmin', obj.img(2).vol);
        
        if mx1 == 0 && mn2 == 0
              return;
        end
        
        if mx1 ~= 0
        cprompt = ['Colormap: ' imgns{1}];
        obj.img(1).type = 'split';
        dcmap1 = 'hot';
        drange1 = [1 mx1];
%         drange1 = [1 9];
        obj.img(1).prop = 1;
        obj.cbar = [obj.cbar 1];
        obj.img(1).cmap = sf_return_cmap(cprompt, dcmap1);
        obj.img(1).range = drange1;
        end
  
        if mn2 ~=0
        cprompt = ['Colormap: ' imgns{2}];
        obj.img(2).type = 'split';
        dcmap2 = 'winter';
        drange2 = [-1 mn2];
%         drange2 = [-1 -6];
        obj.img(2).prop = 1;
        obj.cbar = [obj.cbar 2];
        obj.img(2).cmap = sf_return_cmap2(cprompt, dcmap2);
        obj.img(2).range = drange2;
        end
  
        obj.img(3).vol = spm_vol(img_structure);
        options = {'Structural','Truecolour', ...
             'Blobs','Negative blobs','Contours'};
        % if there are SPM results in the workspace, add this option
        [XYZ Z M] = pr_get_spm_results;
        if ~isempty(XYZ)
            options = {'Structural with SPM blobs', options{:}};
        end
        itype = 'Structural';
        imgns(3) = {sprintf('Img3 (%s)',itype)};
        [mx mn] = slover('volmaxmin', obj.img(3).vol);
        obj.img(3).type = 'truecolour';
        obj.img(3).cmap = gray;
        obj.img(3).range = [mn mx];
        deftype = 2;
        cscale = [cscale 2];
        if strcmp(itype,'Structural with SPM blobs')
            obj = add_spm(obj);
        end
        
        % 
        obj.transform = 'sagittal';
        % use SPM figure window
        obj.figure = spm_figure('GetWin', 'Graphics'); 
        % slices for display
        obj = fill_defaults(obj);
        slices = obj.slices;
        obj.slices =-54:1.6:54;
        % and do the display
        if dispf, obj = paint(obj); end
        [path,name,ext] = fileparts(imgs{1});
        name_new = strcat(path,'\',name,'_sagittalB.ps');
        pr_print(name_new);
    end
end

return


% Subfunctions 
% ------------
function cmap = sf_return_cmap(prompt,defmapn)
cmap = [];
while isempty(cmap)
  [cmap w]= slover('getcmap','hot');
  if isempty(cmap), disp(w);end
end
return
function cmap = sf_return_cmap2(prompt,defmapn)
cmap = [];
while isempty(cmap)
  [cmap w]= slover('getcmap','winter');
  if isempty(cmap), disp(w);end
end
return
