function varargout = DTI_preprocess(varargin)
% DTI_PREPROCESS MATLAB code for DTI_preprocess.fig
%      DTI_PREPROCESS, by itself, creates a new DTI_PREPROCESS or raises the existing
%      singleton*.
%
%      H = DTI_PREPROCESS returns the handle to a new DTI_PREPROCESS or the handle to
%      the existing singleton*.
%
%      DTI_PREPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DTI_PREPROCESS.M with the given input arguments.
%
%      DTI_PREPROCESS('Property','Value',...) creates a new DTI_PREPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DTI_preprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DTI_preprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DTI_preprocess

% Last Modified by GUIDE v2.5 22-Mar-2024 11:05:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DTI_preprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @DTI_preprocess_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before DTI_preprocess is made visible.
function DTI_preprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DTI_preprocess (see VARARGIN)

% Choose default command line output for DTI_preprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DTI_preprocess wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%-------定义全局变量(nbb-2024.03.22)-----------
global Prepross_parameter;
Prepross_parameter.path = pwd;
Prepross_parameter.sourcedata = '';
% Prepross_parameter.writedata = '';
Prepross_parameter.template = '';
Prepross_parameter.brainmat = '';
%----------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = DTI_preprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Source.
function pushbutton_Source_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_ROI = spm_select(Inf, 'image', 'Select the Nifit files ...');
if isempty(file_ROI)
    errordlg('The Nifiti image should not be empty ....');
    return;
else
    n = size(file_ROI,1);
    for i = 1:n
        clear filetemp;
        t = find(file_ROI(i,:) == 44);
        filetemp = file_ROI(i,1:(t-1));
        Filenew(i,:) = cellstr(filetemp);
        clear filetemp;
    end
    Prepross_parameter.sourcedata = char(Filenew);
    set(handles.listboxSource,'string',file_ROI);
    return;
end

% --- Executes on selection change in listboxSource.
function listboxSource_Callback(hObject, eventdata, handles)
% hObject    handle to listboxSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxSource contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxSource


% --- Executes during object creation, after setting all properties.
function listboxSource_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDTIpath.
function pushbuttonDTIpath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDTIpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
Pathold = Prepross_parameter.path;
ResultPath = uigetdir(Pathold, 'Path of OutPath of Results ....');
if ~isempty(ResultPath)
    Prepross_parameter.path = ResultPath;
    set(handles.textPath,'string',ResultPath);
else
    set(handles.textPath,'string',Pathold);
end

% --- Executes on button press in pushbuttonTemplate.
function pushbuttonTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, 'image', 'Select template image ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
    t = find(file_template == 44);
    Prepross_parameter.template = file_template(1:(t-1));
    set(handles.textTemplate,'string',file_template(1:(t-1)));
    return;
end

% --- Executes on button press in pushbuttonRun.
function pushbuttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
SourceFiles = Prepross_parameter.sourcedata;
Template = Prepross_parameter.template;
Path = Prepross_parameter.path;
Flag = get(handles.checkboxFirst,'Value');
if(Flag)
     DirPath = dir(Path);
     for i = 3:length(DirPath)
         SubName = DirPath(i).name;
         SubPath1 = strcat(Path,filesep,SubName,filesep,'dti_fa.nii');
%          OutPath1 = strcat(Path,filesep,SubName,filesep,'dti_FA.nii');
%          movefile(SubPath1,OutPath1);
         Subj(i-2).FA = SubPath1;
         SubPath = strcat(Path,filesep,SubName,filesep,'dti_adc.nii');
         OutPath = strcat(Path,filesep,SubName,filesep,'dti_MD.nii');
         movefile(SubPath,OutPath);
         Subj(i-2).MD = OutPath;
         SubPathn = strcat(Path,filesep,SubName,filesep,'dti_e1.nii');
         OutPathn = strcat(Path,filesep,SubName,filesep,'dti_AD.nii');
         movefile(SubPathn,OutPathn);
         Subj(i-2).AD = OutPathn;
         SubPath1 = strcat(Path,filesep,SubName,filesep,'dti_e2.nii');
         SubPath2 = strcat(Path,filesep,SubName,filesep,'dti_e3.nii');
         V1 = spm_vol(SubPath1);
         V2 = spm_vol(SubPath2);
         Y1 = spm_read_vols(V1);
         Y2 = spm_read_vols(V2);
         Yout = (Y1+Y2)/2;
         Vout = V1;
         Vout.fname = strcat(Path,filesep,SubName,filesep,'dti_RD.nii');
         Vout = spm_create_vol(Vout);
         spm_write_plane(Vout,Yout,':');
         Subj(i-2).RD = Vout.fname;
         clear SubPath1;
         clear SubPath2;
         clear V1;
         clear V2;
         clear Y1;
         clear Y2;
         clear Yout;
         clear Vout;
     end
    DirPath = dir(Path);
    for ii = 3:length(DirPath)
        SubName = DirPath(ii).name;
        Subj(ii-2).wFA = strcat(Path,filesep,SubName,filesep,'wdti_FA.nii');
        Subj(ii-2).wMD = strcat(Path,filesep,SubName,filesep,'wdti_MD.nii');
        Subj(ii-2).wAD = strcat(Path,filesep,SubName,filesep,'wdti_AD.nii');
        Subj(ii-2).wRD = strcat(Path,filesep,SubName,filesep,'wdti_RD.nii');

        Subj(ii-2).swFA = strcat(Path,filesep,SubName,filesep,'swdti_FA.nii');
        Subj(ii-2).swMD = strcat(Path,filesep,SubName,filesep,'swdti_MD.nii');
        Subj(ii-2).swAD = strcat(Path,filesep,SubName,filesep,'swdti_AD.nii');
        Subj(ii-2).swRD = strcat(Path,filesep,SubName,filesep,'swdti_RD.nii');

        Subj(ii-2).wwFA = strcat(Path,filesep,SubName,filesep,'wwdti_FA.nii');
        Subj(ii-2).wwMD = strcat(Path,filesep,SubName,filesep,'wwdti_MD.nii');
        Subj(ii-2).wwAD = strcat(Path,filesep,SubName,filesep,'wwdti_AD.nii');
        Subj(ii-2).wwRD = strcat(Path,filesep,SubName,filesep,'wwdti_RD.nii');

        Subj(ii-2).swwFA = strcat(Path,filesep,SubName,filesep,'swwdti_FA.nii');
        Subj(ii-2).swwMD = strcat(Path,filesep,SubName,filesep,'swwdti_MD.nii');
        Subj(ii-2).swwAD = strcat(Path,filesep,SubName,filesep,'swwdti_AD.nii');
        Subj(ii-2).swwRD = strcat(Path,filesep,SubName,filesep,'swwdti_RD.nii');
    end

else
    FilePathnbb = Prepross_parameter.sourcedata;
    nbbnnn = size(FilePathnbb,1);
     for i = 1:nbbnnn
         [Pnbb,~,~] = fileparts(FilePathnbb(i,:));
         Subj(i).FA = strcat(Pnbb,'\dti_FA.nii');
         Subj(i).MD = strcat(Pnbb,'\dti_MD.nii');
         Subj(i).AD = strcat(Pnbb,'\dti_AD.nii');
         Subj(i).RD = strcat(Pnbb,'\dti_RD.nii');
     end
     for ii = 1:nbbnnn
        [Pnbb,~,~] = fileparts(FilePathnbb(ii,:));
        Subj(ii).wFA = strcat(Pnbb,'\wdti_FA.nii');
        Subj(ii).wMD = strcat(Pnbb,'\wdti_MD.nii');
        Subj(ii).wAD = strcat(Pnbb,'\wdti_AD.nii');
        Subj(ii).wRD = strcat(Pnbb,'\wdti_RD.nii');

        Subj(ii).swFA = strcat(Pnbb,'\swdti_FA.nii');
        Subj(ii).swMD = strcat(Pnbb,'\swdti_MD.nii');
        Subj(ii).swAD = strcat(Pnbb,'\swdti_AD.nii');
        Subj(ii).swRD = strcat(Pnbb,'\swdti_RD.nii');

        Subj(ii).wwFA = strcat(Pnbb,'\wwdti_FA.nii');
        Subj(ii).wwMD = strcat(Pnbb,'\wwdti_MD.nii');
        Subj(ii).wwAD = strcat(Pnbb,'\wwdti_AD.nii');
        Subj(ii).wwRD = strcat(Pnbb,'\wwdti_RD.nii');

        Subj(ii).swwFA = strcat(Pnbb,'\swwdti_FA.nii');
        Subj(ii).swwMD = strcat(Pnbb,'\swwdti_MD.nii');
        Subj(ii).swwAD = strcat(Pnbb,'\swwdti_AD.nii');
        Subj(ii).swwRD = strcat(Pnbb,'\swwdti_RD.nii');
    end
end
FlagNor = get(handles.checkboxNormalize,'Value');
FlagUser = get(handles.checkboxNorUser,'Value');
SourceNumber = size(SourceFiles,1);
if(FlagNor)
    for si = 1:SourceNumber
        ImagetoWrite = [cellstr(Subj(si).FA);cellstr(Subj(si).MD);cellstr(Subj(si).AD);cellstr(Subj(si).RD)];
        IHEP_old_normalizationDTI(Template,SourceFiles(si,:),char(ImagetoWrite));      
        
        ImagetoSmooth = [cellstr(Subj(si).wFA);cellstr(Subj(si).wMD);cellstr(Subj(si).wAD);cellstr(Subj(si).wRD)];
        IHEPadapttoMIP(char(ImagetoSmooth));
        IHEP_smooth(char(ImagetoSmooth));
        
        ImagetoExtract = [cellstr(Subj(si).swFA);cellstr(Subj(si).swMD);cellstr(Subj(si).swAD);cellstr(Subj(si).swRD)];
        IHEP_mask_images_nbb(char(ImagetoExtract));
        IHEP_mask_images_nbb(char(ImagetoSmooth));
        clear ImagetoExtract;
        clear ImagetoSmooth;
        clear ImagetoWrite;
    end
else
    if(FlagUser)
        MatFile = Prepross_parameter.brainmat;
         for si = 1:SourceNumber
             ImagetoWrite = [cellstr(Subj(si).FA);cellstr(Subj(si).MD);cellstr(Subj(si).AD);cellstr(Subj(si).RD)];
             IHEP_old_normalization_touserDTI(Template,SourceFiles(si,:),char(ImagetoWrite));
             ImagetoWrite2 = [cellstr(Subj(si).wFA);cellstr(Subj(si).wMD);cellstr(Subj(si).wAD);cellstr(Subj(si).wRD)];
             IHEP_to_use_write_old_normalization(MatFile,char(ImagetoWrite2));
             ImagetoSmooth = [cellstr(Subj(si).wwFA);cellstr(Subj(si).wwMD);cellstr(Subj(si).wwAD);cellstr(Subj(si).wwRD)];
            IHEPadapttoMIP(char(ImagetoSmooth));
            IHEP_smooth(char(ImagetoSmooth));
            ImagetoExtract = [cellstr(Subj(si).swwFA);cellstr(Subj(si).swwMD);cellstr(Subj(si).swwAD);cellstr(Subj(si).swwRD)];
            IHEP_mask_images_nbb(char(ImagetoExtract));
            IHEP_mask_images_nbb(char(ImagetoSmooth));
            clear ImagetoWrite;
            clear ImagetoWrite2;
            clear ImagetoSmooth;
            clear ImagetoExtract;
        end
    end
end

 disp('                   ALL THE DTI PREPROCESSES DONE.');




% --- Executes on button press in checkboxFirst.
function checkboxFirst_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFirst


% --- Executes on button press in checkboxNormalize.
function checkboxNormalize_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNormalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxNormalize


% --- Executes on button press in checkboxNorUser.
function checkboxNorUser_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNorUser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxNorUser


% --- Executes on button press in pushbuttonUserMean.
function pushbuttonUserMean_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonUserMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, 'image', 'Select UserMean image ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
    t = find(file_template == 44);
    Prepross_parameter.template = file_template(1:(t-1));
    set(handles.textUserMean,'string',file_template(1:(t-1)));
    return;
end

% --- Executes on button press in pushbuttonBrainMat.
function pushbuttonBrainMat_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBrainMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Prepross_parameter;
file_template = spm_select(1, '.mat$', 'Select user matfile ...');
if isempty(file_template)
    errordlg('The template image should not be empty ....');
    return;
else
%     t = find(file_template == 44);
    Prepross_parameter.brainmat = file_template;
    set(handles.text4,'string',file_template);
    return;
end
