function varargout = PET_preprocess(varargin)
% PET_PREPROCESS MATLAB code for PET_preprocess.fig
%      PET_PREPROCESS, by itself, creates a new PET_PREPROCESS or raises the existing
%      singleton*.
%
%      H = PET_PREPROCESS returns the handle to a new PET_PREPROCESS or the handle to
%      the existing singleton*.
%
%      PET_PREPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PET_PREPROCESS.M with the given input arguments.
%
%      PET_PREPROCESS('Property','Value',...) creates a new PET_PREPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PET_preprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PET_preprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PET_preprocess

% Last Modified by GUIDE v2.5 21-Mar-2024 16:49:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PET_preprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @PET_preprocess_OutputFcn, ...
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


% --- Executes just before PET_preprocess is made visible.
function PET_preprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PET_preprocess (see VARARGIN)

% Choose default command line output for PET_preprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PET_preprocess wait for user response (see UIRESUME)
% uiwait(handles.figure_PET_PREPROCESS);
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
Prepross_parameter.data = '';
Prepross_parameter.template = '';

set(handles.radiobutton_wholebrain,'Enable','off');
set(handles.radiobutton_GrayMatter,'Enable','off');
set(handles.radiobutton_Cerebellum,'Enable','off');
set(handles.radiobutton_Pons,'Enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = PET_preprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Run.
function pushbutton_Run_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-------定义全局变量(nbb-2021.06.24)-----------
global Prepross_parameter;
%---------------------------------------------
Files = Prepross_parameter.data;
Template = Prepross_parameter.template;

    Flipx = get(handles.checkbox_Flipx,'Value');
    Flipy = get(handles.checkbox_flipy,'Value');
    Flipz = get(handles.checkbox_flipz,'Value');
    IHEP_change_header_PET(Files,Flipx,Flipy,Flipz);

if(get(handles.checkbox5,'Value'))
    IHEP_old_normalization(Template,Files,Files);
    NumFiles = size(Files,1);
    for i = 1:NumFiles
        [P,N,E] = fileparts(Files(i,:));
        Filesw(i,:)= cellstr(strcat(P,filesep,'w',N,E));
        Filessw(i,:)= cellstr(strcat(P,filesep,'sw',N,E));
        Filemssw(i,:) = cellstr(strcat(P,filesep,'Brainsw',N,E));
    end
        Fileswn = char(Filesw);
        Filesswn = char(Filessw);
        IHEPadapttoMIP(Fileswn);
        IHEP_smooth(Fileswn);
        IHEP_mask_images_nbb(Filesswn);
        SaveSUVRFlag = get(handles.checkbox_SaveSUVR,'Value');
        if(SaveSUVRFlag)
            Filemsswn = char(Filemssw);
            ReferenceWB = get(handles.radiobutton_wholebrain,'Value');
            ReferenceGM = get(handles.radiobutton_GrayMatter,'Value');
            ReferenceCB = get(handles.radiobutton_Cerebellum,'Value');
            ReferencePons = get(handles.radiobutton_Pons,'Value');
            if(ReferenceWB)
                FlagSUVRreference = 1;
            else if(ReferenceGM)
                    FlagSUVRreference = 2;
                else if(ReferenceCB)
                        FlagSUVRreference = 3;
                    else if(ReferencePons)
                            FlagSUVRreference = 4;
                        end
                    end
                end
            end
            IHEP_save_suvrImages(Filemsswn,FlagSUVRreference);
        end
        clear Filesn;
        clear Filesnn; 
else
     SaveSUVRFlag = get(handles.checkbox_SaveSUVR,'Value');
        if(SaveSUVRFlag)
            Filemsswn = char(Files);
            ReferenceWB = get(handles.radiobutton_wholebrain,'Value');
            ReferenceGM = get(handles.radiobutton_GrayMatter,'Value');
            ReferenceCB = get(handles.radiobutton_Cerebellum,'Value');
            ReferencePons = get(handles.radiobutton_Pons,'Value');
            if(ReferenceWB)
                FlagSUVRreference = 1;
            else if(ReferenceGM)
                    FlagSUVRreference = 2;
                else if(ReferenceCB)
                        FlagSUVRreference = 3;
                    else if(ReferencePons)
                            FlagSUVRreference = 4;
                        end
                    end
                end
            end
            IHEP_save_suvrImages(Filemsswn,FlagSUVRreference);
        end
end
    disp('                   ALL THE PET PREPROCESSES DONE.');


% --- Executes on button press in pushbutton_template.
function pushbutton_template_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_template (see GCBO)
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
    set(handles.Template_name,'string',file_template(1:(t-1)));
    return;
end

% --- Executes on button press in pushbutton_Load_file.
function pushbutton_Load_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Load_file (see GCBO)
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
    Prepross_parameter.data = char(Filenew);
    set(handles.listbox_niifiles,'string',file_ROI);
    return;
end

% --- Executes on selection change in listbox_niifiles.
function listbox_niifiles_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_niifiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_niifiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_niifiles


% --- Executes during object creation, after setting all properties.
function listbox_niifiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_niifiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_Flipx.
function checkbox_Flipx_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Flipx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Flipx


% --- Executes on button press in checkbox_flipy.
function checkbox_flipy_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_flipy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_flipy


% --- Executes on button press in checkbox_flipz.
function checkbox_flipz_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_flipz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_flipz


% --- Executes on button press in checkbox_SaveSUVR.
function checkbox_SaveSUVR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SaveSUVR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SaveSUVR
SaveSUVRFlag = get(handles.checkbox_SaveSUVR,'Value');
if(SaveSUVRFlag)
    set(handles.radiobutton_wholebrain,'Enable','on');
    set(handles.radiobutton_GrayMatter,'Enable','on');
    set(handles.radiobutton_Cerebellum,'Enable','on');
    set(handles.radiobutton_Pons,'Enable','on');
    set(handles.radiobutton_wholebrain,'Value',1);
else
    set(handles.radiobutton_wholebrain,'Enable','off');
    set(handles.radiobutton_GrayMatter,'Enable','off');
    set(handles.radiobutton_Cerebellum,'Enable','off');
    set(handles.radiobutton_Pons,'Enable','off');
    set(handles.radiobutton_wholebrain,'Value',0);
end

% --- Executes on button press in radiobutton_wholebrain.
function radiobutton_wholebrain_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_wholebrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_wholebrain
set(handles.radiobutton_GrayMatter,'Value',0);
set(handles.radiobutton_Cerebellum,'Value',0);
set(handles.radiobutton_Pons,'Value',0);
set(handles.radiobutton_wholebrain,'Value',1);

% --- Executes on button press in radiobutton_Cerebellum.
function radiobutton_Cerebellum_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Cerebellum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Cerebellum
set(handles.radiobutton_GrayMatter,'Value',0);
set(handles.radiobutton_Cerebellum,'Value',1);
set(handles.radiobutton_Pons,'Value',0);
set(handles.radiobutton_wholebrain,'Value',0);

% --- Executes on button press in radiobutton_Pons.
function radiobutton_Pons_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Pons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Pons
set(handles.radiobutton_GrayMatter,'Value',0);
set(handles.radiobutton_Cerebellum,'Value',0);
set(handles.radiobutton_Pons,'Value',1);
set(handles.radiobutton_wholebrain,'Value',0);

% --- Executes on button press in radiobutton_GrayMatter.
function radiobutton_GrayMatter_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_GrayMatter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_GrayMatter
set(handles.radiobutton_GrayMatter,'Value',1);
set(handles.radiobutton_Cerebellum,'Value',0);
set(handles.radiobutton_Pons,'Value',0);
set(handles.radiobutton_wholebrain,'Value',0);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
