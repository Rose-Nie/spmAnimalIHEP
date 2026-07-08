function varargout = changeheaderIHEP(varargin)
% CHANGEHEADERIHEP M-file for changeheaderIHEP.fig
%      CHANGEHEADERIHEP, by itself, creates a new CHANGEHEADERIHEP or raises the existing
%      singleton*.
%
%      H = CHANGEHEADERIHEP returns the handle to a new CHANGEHEADERIHEP or the handle to
%      the existing singleton*.
%
%      CHANGEHEADERIHEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHANGEHEADERIHEP.M with the given input arguments.
%
%      CHANGEHEADERIHEP('Property','Value',...) creates a new CHANGEHEADERIHEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before changeheaderIHEP_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to changeheaderIHEP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help changeheaderIHEP

% Last Modified by GUIDE v2.5 25-Jun-2021 17:40:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @changeheaderIHEP_OpeningFcn, ...
                   'gui_OutputFcn',  @changeheaderIHEP_OutputFcn, ...
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


% --- Executes just before changeheaderIHEP is made visible.
function changeheaderIHEP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to changeheaderIHEP (see VARARGIN)

% Choose default command line output for changeheaderIHEP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes changeheaderIHEP wait for user response (see UIRESUME)
% uiwait(handles.figure_Changeheader);


% --- Outputs from this function are returned to the command line.
function varargout = changeheaderIHEP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in voxelsize.
function voxelsize_Callback(hObject, eventdata, handles)
% hObject    handle to voxelsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of voxelsize


% --- Executes on button press in scale.
function scale_Callback(hObject, eventdata, handles)
% hObject    handle to scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of scale


% --- Executes on button press in origin.
function origin_Callback(hObject, eventdata, handles)
% hObject    handle to origin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of origin



function voxelsizeedit_Callback(hObject, eventdata, handles)
% hObject    handle to voxelsizeedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voxelsizeedit as text
%        str2double(get(hObject,'String')) returns contents of voxelsizeedit as a double


% --- Executes during object creation, after setting all properties.
function voxelsizeedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voxelsizeedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scaleedit_Callback(hObject, eventdata, handles)
% hObject    handle to scaleedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scaleedit as text
%        str2double(get(hObject,'String')) returns contents of scaleedit as a double


% --- Executes during object creation, after setting all properties.
function scaleedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scaleedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function originedit_Callback(hObject, eventdata, handles)
% hObject    handle to originedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of originedit as text
%        str2double(get(hObject,'String')) returns contents of originedit as a double


% --- Executes during object creation, after setting all properties.
function originedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to originedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in imagelist.
function imagelist_Callback(hObject, eventdata, handles)
% hObject    handle to imagelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns imagelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imagelist


% --- Executes during object creation, after setting all properties.
function imagelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in inputimage.
function inputimage_Callback(hObject, eventdata, handles)
% hObject    handle to inputimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileimages = spm_select(Inf,'.nii$','Please choose images to change header ...');
set(handles.imagelist,'String',fileimages);
return;

% --- Executes on button press in runchange.
function runchange_Callback(hObject, eventdata, handles)
% hObject    handle to runchange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%---------------------------------------------------------
% 容错判断：是否设定头文件参数；头文件参数是否正确；是否读入图像
% nbb  2012.6.4
voxelsize_check_nbb = get(handles.voxelsize,'Value');
scale_check_nbb = get(handles.scale,'Value');
origin_check_nbb = get(handles.origin,'Value');
if ~(voxelsize_check_nbb || scale_check_nbb || origin_check_nbb)
    errordlg('Please choose a parameter to change at least ....');
    return;
end

images_string = get(handles.imagelist,'String');
if isempty(images_string)
    errordlg('Please choose images to change header ....');
    return;
end

if voxelsize_check_nbb
    str_voxelsize_nbb = get(handles.voxelsizeedit,'String');
    voxelsize_nbb = str2num(str_voxelsize_nbb);
    if size(voxelsize_nbb,2) ~= 3
        errordlg('Please input three numbers for voxel size. There is a space between each number ....');
        return;
    else
        header.voxelsize = voxelsize_nbb;
    end
end
if scale_check_nbb
    str_scale_nbb = get(handles.scaleedit,'String');
    scale_nbb = str2num(str_scale_nbb);
    if size(scale_nbb,2) ~= 1;
        errordlg('Please input one number for scale ....');
        return;
    else
        header.scale = scale_nbb;
    end
end
if origin_check_nbb
    str_origin_nbb = get(handles.originedit,'String');
    origin_nbb = str2num(str_origin_nbb);
    if size(origin_nbb,2) ~= 3;
        errordlg('Please input three numbers for origin. There is a space between each number ....');
        return;
    else
        header.origin = origin_nbb;
    end
end
%---------------------------------------------------------

%---------------------------------------------------------
% 更改头文件
% nbb 2012.6.5
image_nums = size(images_string,1);
for i_nums = 1:image_nums
    imagename = images_string(i_nums,:);
    [DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN] = IHEP_hread(imagename);
    if isfield(header,'voxelsize')
        VOX = header.voxelsize;
    end
    if isfield(header,'scale')
        SCALE = header.scale;
    end
    if isfield(header,'origin')
        ORIGIN = header.origin;
    end
    IHEP_hwrite(imagename, DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN);
end
msgbox('All the headers of the images have been changed.','Change_Header Done');
%---------------------------------------------------------
%---------------------------------------------------------
% 恢复初始化界面
set(handles.voxelsize,'Value',0);
set(handles.scale,'Value',0);
set(handles.origin,'Value',0);
set(handles.voxelsizeedit,'String','');
set(handles.scaleedit,'String','');
set(handles.originedit,'String','');
set(handles.imagelist,'String','');
%---------------------------------------------------------
