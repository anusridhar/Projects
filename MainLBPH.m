function varargout = MainLBPH(varargin)
% MAINLBPH MATLAB code for MainLBPH.fig
%      MAINLBPH, by itself, creates a new MAINLBPH or raises the existing
%      singleton*.
%
%      H = MAINLBPH returns the handle to a new MAINLBPH or the handle to
%      the existing singleton*.
%
%      MAINLBPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINLBPH.M with the given input arguments.
%
%      MAINLBPH('Property','Value',...) creates a new MAINLBPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainLBPH_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainLBPH_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainLBPH

% Last Modified by GUIDE v2.5 08-Jan-2018 15:42:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainLBPH_OpeningFcn, ...
                   'gui_OutputFcn',  @MainLBPH_OutputFcn, ...
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


% --- Executes just before MainLBPH is made visible.
function MainLBPH_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainLBPH (see VARARGIN)

% Choose default command line output for MainLBPH
handles.output = hObject;
% title('Face Recognition using Local Binary Pattern Histogram and Haar Cascading Algorithm')


% Update handles structure

guidata(hObject, handles);

% UIWAIT makes MainLBPH wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainLBPH_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grayImage
global Image
global localBinaryPatternImage
global rows columns

[filename pathname id]=uigetfile({'.pgm'}, 'Select Input Image',[cd '\AT & T\']);
if ~id,return, end
grayImage = imread([pathname filename]);

% grayImage=imread(Image)
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
axes(handles.axes1)
imshow(grayImage);
% Enlarge figure to full screen.
set(gcf, 'Position'); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grayImage
global Image
global localBinaryPatternImage
global rows columns

% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(grayImage);
% subplot(2, 2, 2); 
axes(handles.axes4)
bar(pixelCount);
xlim([0 grayLevels(end)]); % Scale x axis manually.

set(gcf, 'Position'); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grayImage
global Image
global localBinaryPatternImage
global rows columns

% Preallocate/instantiate array for the local binary pattern.
localBinaryPatternImage = zeros(size(grayImage));
for row = 2 : rows - 1   
    for col = 2 : columns - 1    
        centerPixel = grayImage(row, col);
        pixel7=grayImage(row-1, col-1) > centerPixel;  
        pixel6=grayImage(row-1, col) > centerPixel;   
        pixel5=grayImage(row-1, col+1) > centerPixel;  
        pixel4=grayImage(row, col+1) > centerPixel;     
        pixel3=grayImage(row+1, col+1) > centerPixel;    
        pixel2=grayImage(row+1, col) > centerPixel;      
        pixel1=grayImage(row+1, col-1) > centerPixel;     
        pixel0=grayImage(row, col-1) > centerPixel;       
        localBinaryPatternImage(row, col) = uint8(...
            pixel7 * 2^7 + pixel6 * 2^6 + ...
            pixel5 * 2^5 + pixel4 * 2^4 + ...
            pixel3 * 2^3 + pixel2 * 2^2 + ...
            pixel1 * 2 + pixel0);
    end  
end 
% subplot(2,2,3);
axes(handles.axes2)
imshow(localBinaryPatternImage, []);

set(gcf, 'Position'); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grayImage
global Image
global localBinaryPatternImage
global rows columns

axes(handles.axes5)
% subplot(2,2,4);
[pixelCounts, GLs] = imhist(uint8(localBinaryPatternImage));
bar(pixelCounts);
imshow(bar(pixelCounts));

set(gcf, 'Position'); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grayImage localBinaryPatternImage

%Haar cascading Boundiong Box
faceDetector = vision.CascadeObjectDetector;
bboxes = step(faceDetector, grayImage);
IFaces = insertObjectAnnotation(grayImage, 'rectangle', bboxes, 'Face');   
axes(handles.axes3),
imshow(IFaces);


set(gcf, 'Position'); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 
