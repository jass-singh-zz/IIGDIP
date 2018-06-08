function varargout = Object_Detection_Module(varargin)
% OBJECT_DETECTION_MODULE MATLAB code for Object_Detection_Module.fig
%      OBJECT_DETECTION_MODULE, by itself, creates a new OBJECT_DETECTION_MODULE or raises the existing
%      singleton*.
%
%      H = OBJECT_DETECTION_MODULE returns the handle to a new OBJECT_DETECTION_MODULE or the handle to
%      the existing singleton*.
%
%      OBJECT_DETECTION_MODULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBJECT_DETECTION_MODULE.M with the given input arguments.
%
%      OBJECT_DETECTION_MODULE('Property','Value',...) creates a new OBJECT_DETECTION_MODULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Object_Detection_Module_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Object_Detection_Module_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Object_Detection_Module

% Last Modified by GUIDE v2.5 21-Mar-2018 02:23:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Object_Detection_Module_OpeningFcn, ...
                   'gui_OutputFcn',  @Object_Detection_Module_OutputFcn, ...
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


% --- Executes just before Object_Detection_Module is made visible.
function Object_Detection_Module_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Object_Detection_Module (see VARARGIN)

% Choose default command line output for Object_Detection_Module
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Object_Detection_Module wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Object_Detection_Module_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ObjectBrowse.
function ObjectBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to ObjectBrowse (see GCBO)
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
set(handles.Object1,'string',' ');
set(handles.Object2,'string',' ');
set(handles.Object3,'string',' ');
delete('Data\SRC\*.jpg');
delete('Data\Proposed\*.png');
[filename, pathname]= uigetfile('*.jpg','Select an Image for Effect');
iview=imread(strcat(pathname,filename));
imwrite(iview,['Data\SRC\',filename]);
set(handles.Object1,'string','Ready to Deploy Effect ...');

% --- Executes on button press in ObjectDetect.
function ObjectDetect_Callback(hObject, eventdata, handles)
% hObject    handle to ObjectDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Out II;
set(handles.Object1,'string',' ');
set(handles.Object2,'string',' ');
set(handles.Object3,'string',' ');
set(handles.Object1,'string','Processing Started ...');
pause(1);
set(handles.Object2,'string','Fetching useful regions ...');
pause(1);
Out=Main_1ObjDet();
pics_name=dir(fullfile('Data/SRC/*.jpg'));
pro_name=dir(fullfile('Data/Proposed/*.png'));

II=imread(fullfile('Data/SRC/',pics_name(1).name));
Out=uint8(Out>165).*Out;

bw = bwlabel(Out, 8); %8 [10-11] se upar me and [4-5] se neeche me problem aati hai 
stats = regionprops(bw, 'BoundingBox', 'Centroid');
    min_dimen=20;
    stats=filter_detectons(stats,min_dimen);
    coorVal=[255;0;0];
    dimofimage=size(II);
    thick=ceil(dimofimage*0.004);
    thick=thick(1);
    II = PlotBoxes(II,stats,coorVal,thick);
figure,imshow(II);
imwrite(II,['Data\Proposed\' pro_name(1).name(1:end-4) '.png']);

set(handles.Object3,'string','Process Completed ...');


% --- Executes on button press in ObjectSave.
function ObjectSave_Callback(hObject, eventdata, handles)
% hObject    handle to ObjectSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global II;
set(handles.Object1,'string',' ');
set(handles.Object2,'string',' ');
set(handles.Object3,'string',' ');
pro_name=dir(fullfile('Data/Proposed/*.png'));
folder_name = uigetdir('C:\','Select directory to save Image');
imwrite(II,[folder_name '\' pro_name(1).name]);
set(handles.Object1,'string',strcat('Image Saved at location : ',folder_name));
delete('Data\SRC\*.jpg');
delete('Data\Res\*.png');
delete('Data\Proposed\*.png');
delete('Data\Edges\*.jpg');
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
if exist('Data', 'dir')
    rmdir('Data');
end
