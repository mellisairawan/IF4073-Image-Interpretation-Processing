function varargout = Homework1(varargin)
% HOMEWORK1 MATLAB code for Homework1.fig
%      HOMEWORK1, by itself, creates a new HOMEWORK1 or raises the existing
%      singleton*.
%
%      H = HOMEWORK1 returns the handle to a new HOMEWORK1 or the handle to
%      the existing singleton*.
%
%      HOMEWORK1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEWORK1.M with the given input arguments.
%
%      HOMEWORK1('Property','Value',...) creates a new HOMEWORK1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Homework1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Homework1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Homework1

% Last Modified by GUIDE v2.5 22-Sep-2022 13:53:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Homework1_OpeningFcn, ...
                   'gui_OutputFcn',  @Homework1_OutputFcn, ...
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


% --- Executes just before Homework1 is made visible.
function Homework1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Homework1 (see VARARGIN)

% Image 1
handles.Bean_Gray = imread('standard_test_images/bean.tif');

% Image 2
handles.Boat_Gray = imread('standard_test_images/boat.bmp');

% Image 3
handles.Girl_Gray = imread('standard_test_images/girl.bmp');

% Image 4
handles.Girl_Color = imread('standard_test_images/girl-warna.bmp');

% Image 5
handles.Goldhill_Gray = imread('standard_test_images/Goldhill.tif');

% Image 6
handles.Lena_Gray = imread('standard_test_images/lena_gray_512.tif');

% Image 7
handles.Lena_Color = imread('standard_test_images/lena_color_512.tif');

% Image 8
handles.Mandril_Gray = imread('standard_test_images/mandril_gray.tif');

% Image 9
handles.Mandril_Color = imread('standard_test_images/mandril_color.tif');

% Image 10
handles.Peppers_Gray = imread('standard_test_images/peppers_gray.tif');

% Image 11
handles.Peppers_Color = imread('standard_test_images/peppers_color.tif');

% Image 12
handles.Zelda_Gray = imread('standard_test_images/zelda.bmp');

% Image 13
handles.Strawberry_Color = imread('standard_test_images/strawberries_color.tif');

% Image 14
handles.Cameraman_Gray = imread('standard_test_images/cameraman.tif');

% Image 15
handles.House_Gray = imread('standard_test_images/house.tif');

% Image 16
handles.Caster_Color = imread('standard_test_images/caster.tif');

% Image 17
handles.Pirate_Gray = imread('standard_test_images/pirate.tif');

handles.currentData = handles.Bean_Gray;
axes(handles.axes1);
imshow(handles.currentData);

handles.reffData = handles.Bean_Gray;
axes(handles.axes2);
imshow(handles.reffData);
%[Hist, Graph] = Image_Histogram(handles.currentData);

% Choose default command line output for Homework1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Homework1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Homework1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in InputImage_Menu.
function InputImage_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to InputImage_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');

switch str{val}
    case 'Bean Gray'
        handles.currentData = handles.Bean_Gray;
    case 'Boat Gray'
        handles.currentData = handles.Boat_Gray;
    case 'Girl Gray'
        handles.currentData = handles.Girl_Gray;    
    case 'Girl Color'
        handles.currentData = handles.Girl_Color;
    case 'Goldhill Gray'
        handles.currentData = handles.Goldhill_Gray;  
    case 'Lena Gray'
        handles.currentData = handles.Lena_Gray;
    case 'Lena Color'
        handles.currentData = handles.Lena_Color;    
    case 'Mandril Gray'
        handles.currentData = handles.Mandril_Gray;   
    case 'Mandril Color'
        handles.currentData = handles.Mandril_Color;
    case 'Peppers Gray'
        handles.currentData = handles.Peppers_Gray;    
    case 'Peppers Color'
        handles.currentData = handles.Peppers_Color;
    case 'Zelda Gray'
        handles.currentData = handles.Zelda_Gray;
    case 'Strawberry Color'
        handles.currentData = handles.Strawberry_Color;
    case 'Cameraman Gray'
        handles.currentData = handles.Cameraman_Gray;
    case 'House Gray'
        handles.currentData = handles.House_Gray;
    case 'Caster Color'
        handles.currentData = handles.Caster_Color;
    case 'Pirate Gray'
        handles.currentData = handles.Pirate_Gray;
end
% Save Handles Structure
guidata(hObject, handles)
axes(handles.axes1);
imshow(handles.currentData);
% Hints: contents = cellstr(get(hObject,'String')) returns InputImage_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputImage_Menu


% --- Executes during object creation, after setting all properties.
function InputImage_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputImage_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CreateHistogram_PushButton.
function CreateHistogram_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateHistogram_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
[Hist, Graph] = Image_Histogram(handles.currentData);

% --- Executes on button press in HistogramEq_PushButton.
function HistogramEq_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to HistogramEq_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
[EqImage, input_Hist, new_imageHist] = HistEq(handles.currentData);

% --- Executes on button press in DeployImage_PushButton.
function DeployImage_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeployImage_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow(handles.currentData);

function ImBright_a_Callback(hObject, eventdata, handles)
% hObject    handle to ImBright_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImBright_a as text
%        str2double(get(hObject,'String')) returns contents of ImBright_a as a double


% --- Executes during object creation, after setting all properties.
function ImBright_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImBright_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImBright_b_Callback(hObject, eventdata, handles)
% hObject    handle to ImBright_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImBright_b as text
%        str2double(get(hObject,'String')) returns contents of ImBright_b as a double


% --- Executes during object creation, after setting all properties.
function ImBright_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImBright_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ImageBrightening_PushButton.
function ImageBrightening_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to ImageBrightening_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
a = str2double(get(handles.ImBright_a, 'string'));
b = str2double(get(handles.ImBright_b, 'string'));
[output_image, p1, p2] = image_brightening(handles.currentData, a, b);


% --- Executes on button press in ContrastStretch_PushButton.
function ContrastStretch_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to ContrastStretch_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
[output_image, output_Hist] = contrast_stretch(handles.currentData);

% --- Executes on button press in LogTrans_PushButton.
function LogTrans_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to LogTrans_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
c = str2double(get(handles.LogTrans_c, 'string'));
[output_image, p1, p2] = log_transformation(handles.currentData, c);


function LogTrans_c_Callback(hObject, eventdata, handles)
% hObject    handle to LogTrans_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LogTrans_c as text
%        str2double(get(hObject,'String')) returns contents of LogTrans_c as a double


% --- Executes during object creation, after setting all properties.
function LogTrans_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LogTrans_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ExpTrans_PushButton.
function ExpTrans_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExpTrans_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
c = str2double(get(handles.ExpTrans_c, 'string'));
gamma = str2double(get(handles.ExpTrans_gamma, 'string'));
[output_image, p1, p2] = exponential_transformation(handles.currentData, c, gamma);


function ExpTrans_c_Callback(hObject, eventdata, handles)
% hObject    handle to ExpTrans_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExpTrans_c as text
%        str2double(get(hObject,'String')) returns contents of ExpTrans_c as a double


% --- Executes during object creation, after setting all properties.
function ExpTrans_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExpTrans_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ExpTrans_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to ExpTrans_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExpTrans_gamma as text
%        str2double(get(hObject,'String')) returns contents of ExpTrans_gamma as a double


% --- Executes during object creation, after setting all properties.
function ExpTrans_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExpTrans_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ReffImg_Menu.
function ReffImg_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to ReffImg_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');

switch str{val}
    case 'Bean Gray'
        handles.reffData = handles.Bean_Gray;
    case 'Boat Gray'
        handles.reffData = handles.Boat_Gray;
    case 'Girl Gray'
        handles.reffData = handles.Girl_Gray;    
    case 'Girl Color'
        handles.reffData = handles.Girl_Color;
    case 'Goldhill Gray'
        handles.reffData = handles.Goldhill_Gray;  
    case 'Lena Gray'
        handles.reffData = handles.Lena_Gray;
    case 'Lena Color'
        handles.reffData = handles.Lena_Color;    
    case 'Mandril Gray'
        handles.reffData = handles.Mandril_Gray;   
    case 'Mandril Color'
        handles.reffData = handles.Mandril_Color;
    case 'Peppers Gray'
        handles.reffData = handles.Peppers_Gray;    
    case 'Peppers Color'
        handles.reffData = handles.Peppers_Color;
    case 'Zelda Gray'
        handles.reffData = handles.Zelda_Gray;
    case 'Strawberry Color'
        handles.reffData = handles.Strawberry_Color;
    case 'Cameraman Gray'
        handles.reffData = handles.Cameraman_Gray;
    case 'House Gray'
        handles.reffData = handles.House_Gray;
    case 'Caster Color'
        handles.reffData = handles.Caster_Color;
    case 'Pirate Gray'
        handles.reffData = handles.Pirate_Gray;
end
% Save Handles Structure
guidata(hObject, handles)
axes(handles.axes2);
imshow(handles.reffData);
% Hints: contents = cellstr(get(hObject,'String')) returns ReffImg_Menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ReffImg_Menu


% --- Executes during object creation, after setting all properties.
function ReffImg_Menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReffImg_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ImageSpec_PushButton.
function ImageSpec_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSpec_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
[OutputImage, OutputHist] = histogram_specification(handles.currentData, handles.reffData);
