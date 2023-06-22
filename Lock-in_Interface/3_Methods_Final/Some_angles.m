function varargout = Some_angles(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Some_angles_OpeningFcn, ...
                   'gui_OutputFcn',  @Some_angles_OutputFcn, ...
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

function Some_angles_OpeningFcn(hObject, eventdata, handles, varargin)
global amp1 fas1 pend tituloAmp

amp1 = varargin{1};
fas1 = varargin{2};
pend = varargin{3};
tituloAmp = varargin{4};
handles.output = hObject;
guidata(hObject, handles);

function varargout = Some_angles_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
global perfiles sel
step = get(handles.edit1,'String');
angle= get(handles.edit2,'String');
[fil,col] = size(perfiles);
c(1,:) = {'r (x 10^(-3) m)','Amplitude','ln(Amp)','Phase'};
if sel==1
    P = cell(fil+1,4);
    P(1,1) = c(1,1);
    P(1,2) = c(1,2);
    P(1,3) = c(1,3);
    P(1,4) = c(1,4);    
    for f=1:1:fil
        for c=6:1:9           
            P(f+1,c-5)=num2cell(perfiles(f,c));
        end
    end
    s = strcat('Profile_',angle,'°.xlsx');    
elseif sel==2    
    P = cell(fil+1,col);    
    for i=1:5:col
        P(1,i) = c(1,1);
        P(1,i+1) = c(1,2);
        P(1,i+2) = c(1,3);
        P(1,i+3) = c(1,4);
    end
    for f=1:1:fil
        for c=1:1:col
            P(f+1,c)=num2cell(perfiles(f,c));
        end
    end
    s = strcat('Profiles_Step_',step,'°.xlsx');
end
writecell(P,s)
msgbox("Profiles have been saved successfully","Save");

function edit1_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")   
   set(hObject,'String','15')
else
    valor = str2double(get(hObject,'String'));
    if valor<0 || valor>180
        msgbox("Angle must be between 0° and 180°","Error","error")   
        set(hObject,'String','15')
    end
end

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)

function pushbutton4_Callback(hObject, eventdata, handles)
global amp1 fas1 pend tituloAmp perfiles columnas_perf sel
set(handles.pushbutton6,'Visible','on');
set(handles.pushbutton5,'Visible','on');
% ------------------- DATOS -------------------------
s = get(handles.uibuttongroup1,'SelectedObject');
seleccion = s.String;
switch seleccion
    case 'One profile'
        sel = 1;
        paso_grad = str2double(get(handles.edit2,'String'));
    case 'Several profiles'
        sel = 2;
        paso_grad = str2double(get(handles.edit1,'String'));
end
inicio=0;
final=180;
% ---------------------------------------------------
paso_rad=paso_grad*pi/180;
inicio_rad=inicio*pi/180;
final_rad=final*pi/180;
% --------------- MATRIZ ORIGINAL -------------------
amp = amp1;
fas = fas1;
[filas,columnas]=size(amp);
max_temp = max(max(amp));
[y1,x1] = find(amp==max_temp);
x2 = columnas-x1;
y2 = filas-y1;
rad = min([x1 x2 y1 y2]);
% ----------- NUEVA MATRIZ CUADRADA -----------------
amp_n = amp((y1-rad+1):(y1+rad-1),(x1-rad+1):(x1+rad-1));
fas_n = fas((y1-rad+1):(y1+rad-1),(x1-rad+1):(x1+rad-1));
[filas_n,columnas_n]=size(amp_n);
max_temp_n = max(max(amp_n));
[y1_n,x1_n] = find(amp_n==max_temp_n);

perf = zeros(filas_n,(round(180/paso_grad))*5);
camb=0;
c_pf=1;
for ang_rad=inicio_rad:paso_rad:(final_rad)    
    if ang_rad>=0 && ang_rad<pi/4     
        amp_nt = amp_n.';
        fas_nt = fas_n.';
        [y1_nt,x1_nt] = find(amp_nt==max_temp_n);
        for f=1:filas_n
            perf(f,c_pf) = f*pend/cos(ang_rad);
            ca = abs(y1_nt-f);
            co = round(ca*tan(ang_rad));
            if y1_nt>=f
                camb=0;
            else
                camb=1;
            end
            for c=1:columnas_n
                if c==(x1_nt+co) && camb==0
                    perf(f,c_pf+1) = amp_nt(f,(x1_nt+co));
                    perf(f,c_pf+2) = log(amp_nt(f,(x1_nt+co)));
                    perf(f,c_pf+3) = (pi/180)*fas_nt(f,(x1_nt+co));
                elseif c==(x1_nt-co) && camb==1
                    perf(f,c_pf+1) = amp_nt(f,(x1_nt-co));
                    perf(f,c_pf+2) = log(amp_nt(f,(x1_nt-co)));
                    perf(f,c_pf+3) = (pi/180)*fas_nt(f,(x1_nt-co));
                end
            end
        end
    elseif ang_rad>=pi/4 && ang_rad<pi/2    
        for f=1:filas_n
            perf(f,c_pf) = f*pend/cos(pi/2-ang_rad);
            ca = abs(y1_n-f);
            co = round(ca*tan(pi/2-ang_rad));
            if y1_n>=f
                camb=0;
            else
                camb=1;
            end
            for c=1:columnas_n
                if c==(x1_n+co) && camb==0
                    perf(f,c_pf+1) = amp_n(f,(x1_n+co));
                    perf(f,c_pf+2) = log(amp_n(f,(x1_n+co)));
                    perf(f,c_pf+3) = (pi/180)*fas_n(f,(x1_n+co));
                elseif c==((x1_n-co)) && camb==1
                    perf(f,c_pf+1) = amp_n(f,(x1_n-co));
                    perf(f,c_pf+2) = log(amp_n(f,(x1_n-co)));
                    perf(f,c_pf+3) = (pi/180)*fas_n(f,(x1_n-co));
                end
            end
        end
    elseif ang_rad>=pi/2 && ang_rad<3*pi/4    
        for f=1:filas_n
            perf(f,c_pf) = f*pend/cos(ang_rad-pi/2);
            ca = abs(y1_n-f);
            co = round(ca*tan(ang_rad-pi/2));
            if y1_n>=f
                camb=0;
            else
                camb=1;
            end
            for c=1:columnas_n
                if c==(x1_n-co) && camb==0
                    perf(f,c_pf+1) = amp_n(f,(x1_n-co));
                    perf(f,c_pf+2) = log(amp_n(f,(x1_n-co)));
                    perf(f,c_pf+3) = (pi/180)*fas_n(f,(x1_n-co));
                elseif c==((x1_n+co)) && camb==1
                    perf(f,c_pf+1) = amp_n(f,(x1_n+co));
                    perf(f,c_pf+2) = log(amp_n(f,(x1_n+co)));
                    perf(f,c_pf+3) = (pi/180)*fas_n(f,(x1_n+co));
                end
            end
        end
    elseif ang_rad>=3*pi/4 && ang_rad<pi
        amp_nt = amp_n.';
        fas_nt = fas_n.';
        [y1_nt,x1_nt] = find(amp_nt==max_temp_n);
        for f=1:filas_n
            perf(f,c_pf) = f*pend/cos(pi-ang_rad);
            ca = abs(y1_nt-f);
            co = round(ca*tan(pi-ang_rad));
            if y1_nt>=f
                camb=0;
            else
                camb=1;
            end
            for c=1:columnas_n
                if c==(x1_nt-co) && camb==0
                    perf(f,c_pf+1) = amp_nt(f,(x1_nt-co));
                    perf(f,c_pf+2) = log(amp_nt(f,(x1_nt-co)));
                    perf(f,c_pf+3) = (pi/180)*fas_nt(f,(x1_nt-co));
                elseif c==((x1_nt+co)) && camb==1
                    perf(f,c_pf+1) = amp_nt(f,(x1_nt+co));
                    perf(f,c_pf+2) = log(amp_nt(f,(x1_nt+co)));
                    perf(f,c_pf+3) = (pi/180)*fas_nt(f,(x1_nt+co));
                end
            end
        end
    end
    camb=0;
    c_pf = c_pf+5;    
end
% ----------- CENTRANDO LOS PERFILES EN CERO ----------------
[filas_perf,columnas_perf]=size(perf);
cont=0;
for c=columnas_perf:-1:1
    cont=cont+1;
    if cont==5
        perfi(:,c) = ((perf(:,c)-(perf(round(filas_perf/2),c))));
        cont=0;
    else
        perfi(:,c) = perf(:,c);
    end
end
% ---- INVIRTIENDO LOS DATOS PARA ÁNGULOS <45 Y >135 --------
[filas_perfi,columnas_perfi]=size(perfi);
perfiles = zeros(filas_perfi,columnas_perfi);
for i=0:((columnas_perfi/5)-1)    
    if i*paso_grad<45 || i*paso_grad>=135
        perfiles(:,5*i+1) = perfi(:,5*i+1);
        perfiles(:,5*i+2) = flip(perfi(:,5*i+2));
        perfiles(:,5*i+3) = flip(perfi(:,5*i+3));
        perfiles(:,5*i+4) = flip(perfi(:,5*i+4));
    else
        perfiles(:,5*i+1) = perfi(:,5*i+1);
        perfiles(:,5*i+2) = perfi(:,5*i+2);
        perfiles(:,5*i+3) = perfi(:,5*i+3);
        perfiles(:,5*i+4) = perfi(:,5*i+4);
    end    
end
cla(handles.axes4,'reset')
cla(handles.axes5,'reset')
% ----------- GRAFICANDO TODOS LOS PERFILES -----------------              
if sel==1    
    plot(handles.axes4,perfiles(:,6),perfiles(:,7));
    plot(handles.axes5,perfiles(:,6),perfiles(:,9));
    minR = min(perfiles(:,6));
    maxR = max(perfiles(:,6));
    minAmp = min(perfiles(:,7));
    maxAmp = max(perfiles(:,7));
    minFas = min(perfiles(:,9));
    maxFas = max(perfiles(:,9));
        
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minAmp maxAmp]);
    
    title(handles.axes5,'Phase');
    xlabel(handles.axes5,'Length x10^{-3} m');
    ylabel(handles.axes5,'Phase (rad)');
    axis(handles.axes5,[minR maxR minFas maxFas]);    
elseif sel==2 
                  % -- Amplitudes -- % 
    minAmp = 0;
    maxAmp = 0;
    minR = 0;
    maxR = 0;
    hold(handles.axes4,'on')            
    for i=1:5:columnas_perf                   
        plot(handles.axes4,perfiles(:,i),perfiles(:,i+1));
        minR1 = min(perfiles(:,i));
        maxR1 = max(perfiles(:,i));
        if minR1<minR
            minR = minR1;
        end
        if maxR1>maxR
            maxR = maxR1;
        end

        minAmp1 = min(perfiles(:,i+1));
        maxAmp1 = max(perfiles(:,i+1));
        if minAmp1<minAmp
            minAmp = minAmp1;
        end
        if maxAmp1>maxAmp
            maxAmp = maxAmp1;
        end
    end
    hold(handles.axes4,'off')
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minAmp maxAmp]);
                   % -- Fases -- %
    minFas = 0;
    maxFas = 0;
    hold(handles.axes5,'on') 
    for i=1:5:columnas_perf
        plot(handles.axes5,perfiles(:,i),perfiles(:,i+3));
        minFas1 = min(perfiles(:,i+3));
        maxFas1 = max(perfiles(:,i+3));
        if minFas1<minFas
            minFas = minFas1;
        end
        if maxFas1>maxFas
            maxFas = maxFas1;
        end
    end
    hold(handles.axes5,'off')
    title(handles.axes5,'Phase');
    xlabel(handles.axes5,'Length x10^{-3} m');
    ylabel(handles.axes5,'Phase (rad)');
    axis(handles.axes5,[minR maxR minFas maxFas]);
end
set(handles.pushbutton1,'Enable','on');

function pushbutton5_Callback(hObject, eventdata, handles)
global tituloAmp perfiles columnas_perf sel
cla(handles.axes4,'reset')
if sel==1
    plot(handles.axes4,perfiles(:,6),perfiles(:,7));
    minR = min(perfiles(:,6));
    maxR = max(perfiles(:,6));
    minAmp = min(perfiles(:,7));
    maxAmp = max(perfiles(:,7));
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minAmp maxAmp]);
elseif sel==2
    minAmp = 0;
    maxAmp = 0;
    minR = 0;
    maxR = 0;
    hold(handles.axes4,'on')            
    for i=1:5:columnas_perf
        plot(handles.axes4,perfiles(:,i),perfiles(:,i+1));
        minR1 = min(perfiles(:,i));
        maxR1 = max(perfiles(:,i));
        if minR1<minR
            minR = minR1;
        end
        if maxR1>maxR
            maxR = maxR1;
        end

        minAmp1 = min(perfiles(:,i+1));
        maxAmp1 = max(perfiles(:,i+1));
        if minAmp1<minAmp
            minAmp = minAmp1;
        end
        if maxAmp1>maxAmp
            maxAmp = maxAmp1;
        end    
    end
    hold(handles.axes4,'off')
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minAmp maxAmp]);
end

function pushbutton6_Callback(hObject, eventdata, handles)
global tituloAmp perfiles columnas_perf sel
cla(handles.axes4,'reset')
if sel==1
    plot(handles.axes4,perfiles(:,6),perfiles(:,8));
    minR = min(perfiles(:,6));
    maxR = max(perfiles(:,6));
    minLog = min(perfiles(:,8));
    maxLog = max(perfiles(:,8));
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minLog maxLog]);
elseif sel==2
    minLog = 0;
    maxLog = 0;
    minR = 0;
    maxR = 0;
    hold(handles.axes4,'on')            
    for i=1:5:columnas_perf
        plot(handles.axes4,perfiles(:,i),perfiles(:,i+2));
        minR1 = min(perfiles(:,i));
        maxR1 = max(perfiles(:,i));
        if minR1<minR
            minR = minR1;
        end
        if maxR1>maxR
            maxR = maxR1;
        end

        minLog1 = min(perfiles(:,i+2));
        maxLog1 = max(perfiles(:,i+2));
        if minLog1<minLog
            minLog = minLog1;
        end
        if maxLog1>maxLog
            maxLog = maxLog1;
        end    
    end
    hold(handles.axes4,'off')
    title(handles.axes4,'Amplitude');
    xlabel(handles.axes4,'Length x10^{-3} m');
    ylabel(handles.axes4,tituloAmp);
    axis(handles.axes4,[minR maxR minLog maxLog]);
end

function radiobutton1_Callback(hObject, eventdata, handles)
set(handles.edit1,'Enable','off');
set(handles.edit2,'Enable','on');

function radiobutton2_Callback(hObject, eventdata, handles)
set(handles.edit1,'Enable','on');
set(handles.edit2,'Enable','off');

function edit2_Callback(hObject, eventdata, handles)
r = isnan(str2double(get(hObject,'String')));   
if r   
   msgbox("Invalid Value","Error","error")   
   set(hObject,'String','15')
else
    valor = str2double(get(hObject,'String'));
    if valor<0.01 || valor>180
        msgbox("Angle must be between 0.01° and 180°","Error","error")   
        set(hObject,'String','15')
    end
end

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
