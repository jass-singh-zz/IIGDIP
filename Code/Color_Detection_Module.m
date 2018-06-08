function varargout = Color_Detection_Module(varargin)
% COLOR_DETECTION_MODULE MATLAB code for Color_Detection_Module.fig
%      COLOR_DETECTION_MODULE, by itself, creates a new COLOR_DETECTION_MODULE or raises the existing
%      singleton*.
%
%      H = COLOR_DETECTION_MODULE returns the handle to a new COLOR_DETECTION_MODULE or the handle to
%      the existing singleton*.
%
%      COLOR_DETECTION_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLOR_DETECTION_MODULE.M with the given input arguments.
%
%      COLOR_DETECTION_MODULE('Property','Value',...) creates a new COLOR_DETECTION_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Color_Detection_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Color_Detection_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Color_Detection_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 16:22:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Color_Detection_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Color_Detection_Module_OutputFcn, ...
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


% --- Executes just before Color_Detection_Module is made visible.
function Color_Detection_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Color_Detection_Module (see VARARGIN)

% Choose default command line output for Color_Detection_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Color_Detection_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Color_Detection_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ColoredBrowse.
function ColoredBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to ColoredBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\ColoredResult', 'dir')
    mkdir('Data\ColoredResult');
end
set(handles.ColorDetect1,'string',' ');
set(handles.ColorDetect2,'string',' ');
set(handles.ColorDetect3,'string',' ');
delete('Data\SRC\*.jpg');
delete('Data\ColoredResult\*.png');
[filename, pathname]= uigetfile('*.jpg','Select an Image for Effect');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.ColorDetect1,'string','Ready to Deploy Effect ...');

% --- Executes on button press in DetectColors.
function DetectColors_Callback(hObject, eventdata, handles)
% hObject    handle to DetectColors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.ColorDetect1,'string',' ');
set(handles.ColorDetect2,'string',' ');
set(handles.ColorDetect3,'string',' ');
set(handles.ColorDetect1,'string','Processing Started ...');
pause(1);
set(handles.ColorDetect2,'string','Fetching useful regions ...');
pause(1);
Out=Main_5ColoredResult();
figure,imshow(Out);
set(handles.ColorDetect3,'string','Process Completed ...');


% --- Executes on button press in ColorSave.
function ColorSave_Callback(hObject, eventdata, handles)
% hObject    handle to ColorSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.ColorDetect1,'string',' ');
set(handles.ColorDetect2,'string',' ');
set(handles.ColorDetect3,'string',' ');
pro_name=dir(fullfile('Data/ColoredResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(Out,[folder_name '\' pro_name(1).name]);
set(handles.ColorDetect1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\ColoredResult\*.png');
if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
end
if exist('Data\ColoredResult', 'dir')
   rmdir('Data\ColoredResult');
end
if exist('Data', 'dir')
    rmdir('Data');
end