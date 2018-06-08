function varargout = Submerged_Module(varargin)
% SUBMERGED_MODULE MATLAB code for Submerged_Module.fig
%      SUBMERGED_MODULE, by itself, creates a new SUBMERGED_MODULE or raises the existing
%      singleton*.
%
%      H = SUBMERGED_MODULE returns the handle to a new SUBMERGED_MODULE or the handle to
%      the existing singleton*.
%
%      SUBMERGED_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBMERGED_MODULE.M with the given input arguments.
%
%      SUBMERGED_MODULE('Property','Value',...) creates a new SUBMERGED_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Submerged_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Submerged_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Submerged_Module

% Last Modified by GUIDE v2.5 18-Mar-2018 17:08:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Submerged_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Submerged_Module_OutputFcn, ...
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


% --- Executes just before Submerged_Module is made visible.
function Submerged_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Submerged_Module (see VARARGIN)

% Choose default command line output for Submerged_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global flag;
flag=0;
% UIWAIT makes Submerged_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Submerged_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SubmergedBrowse.
function SubmergedBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to SubmergedBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\RES', 'dir')
    mkdir('Data\RES');
end
if ~exist('Data\Proposed', 'dir')
    mkdir('Data\Proposed');
end
if ~exist('Data\Edges', 'dir')
    mkdir('Data\Edges');
end
if ~exist('Data\SubmergedResult', 'dir')
    mkdir('Data\SubmergedResult');
end
if ~exist('Data\BackgroundIm', 'dir')
    mkdir('Data\BackgroundIm');
end
global flag;
set(handles.Submerged1,'string',' ');
set(handles.Submerged2,'string',' ');
set(handles.Submerged3,'string',' ');
delete('Data\SRC\*.jpg');
delete('Data\SubmergedResult\*.png');

[filename, pathname]= uigetfile('*.jpg','Select an Image for Effect');
iview=imread(strcat(pathname,filename));
axes(handles.SubmergedMainAxes);
imshow(iview);
imwrite(iview,['Data\SRC\',filename]);
flag=flag+1;
set(handles.Submerged1,'string','Selected Foreground Image ...');
if flag==1
set(handles.Submerged2,'string','Now Select Background Image ...');
elseif flag==2
set(handles.Submerged2,'string','Selected Both Images ...');
set(handles.Submerged3,'string','Ready to Deploy Effect ...');
flag=0;
end


% --- Executes on button press in SubmergedEffect.
function SubmergedEffect_Callback(hObject, eventdata, handles)
% hObject    handle to SubmergedEffect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Submerged1,'string',' ');
set(handles.Submerged2,'string',' ');
set(handles.Submerged3,'string',' ');
set(handles.Submerged1,'string','Processing Started ...');
pause(1);
set(handles.Submerged2,'string','Fetching useful regions ...');
pause(1);
Out=Main_7SubmergedResult();
figure,imshow(Out);
set(handles.Submerged3,'string','Process Completed ...');


% --- Executes on button press in SubmergedBackBrowse.
function SubmergedBackBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to SubmergedBackBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('Data', 'dir')
    mkdir('Data');
end
if ~exist('Data\SRC', 'dir')
    mkdir('Data\SRC');
end
if ~exist('Data\SubmergedResult', 'dir')
    mkdir('Data\SubmergedResult');
end
if ~exist('Data\BackgroundIm', 'dir')
    mkdir('Data\BackgroundIm');
end
global flag;
delete('Data\BackgroundIm\*.jpg');

set(handles.Submerged1,'string',' ');
set(handles.Submerged2,'string',' ');
set(handles.Submerged3,'string',' ');
[filename, pathname]= uigetfile('*.jpg','Select an Image for Effect');
iview=imread(strcat(pathname,filename));
axes(handles.SubmergedAxesBack);
imshow(iview);
imwrite(iview,['Data\BackgroundIm\',filename]);
flag=flag+1;
set(handles.Submerged1,'string','Selected Background Image ...');
if flag==1
set(handles.Submerged2,'string','Now Select Foreground Image ...');
elseif flag==2
set(handles.Submerged2,'string','Selected Both Images ...');
set(handles.Submerged3,'string','Ready to Deploy Effect ...');
flag=0;
end


% --- Executes on button press in SubmergedSave.
function SubmergedSave_Callback(hObject, eventdata, handles)
% hObject    handle to SubmergedSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out;
set(handles.Submerged1,'string',' ');
set(handles.Submerged2,'string',' ');
set(handles.Submerged3,'string',' ');
pro_name=dir(fullfile('Data/SubmergedResult/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(Out,[folder_name '\' pro_name(1).name]);
set(handles.Submerged1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\Res\*.png');
delete('Data\Proposed\*.png');
delete('Data\Edges\*.jpg');
delete('Data\SubmergedResult\*.png');
delete('Data\BackgroundIm\*.jpg');
if exist('Data\SRC', 'dir')
    rmdir('Data\SRC');
end
if exist('Data\RES', 'dir')
   rmdir('Data\RES');
end
if exist('Data\Proposed', 'dir')
    rmdir('Data\Proposed');
end
if exist('Data\Edges', 'dir')
    rmdir('Data\Edges');
end
if exist('Data\SubmergedResult', 'dir')
   rmdir('Data\SubmergedResult');
end
if exist('Data\BackgroundIm', 'dir')
   rmdir('Data\BackgroundIm');
end
if exist('Data', 'dir')
    rmdir('Data');
end