function varargout = Profiles(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Profiles_OpeningFcn, ...
                   'gui_OutputFcn',  @Profiles_OutputFcn, ...
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

function Profiles_OpeningFcn(hObject, eventdata, handles, varargin)
global perfiles amp1 fas1 pend tituloAmp

amp1 = varargin{1};
fas1 = varargin{2};
pend = varargin{3};
tituloAmp = varargin{4};

% ------------------- DATOS -------------------------
paso_grad = 90;
inicio=0;
final=90;
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
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
% ----------------- GRAFICANDO LOS PERFILES --------------------
                        % Horizontal %
minRH = min(perfiles(:,1));
maxRH = max(perfiles(:,1));
minAmpH = min(perfiles(:,2));
maxAmpH = max(perfiles(:,2));
plot(handles.axes4,perfiles(:,1),perfiles(:,2));
title(handles.axes4,'Amplitude');
xlabel(handles.axes4,'Length (m)');
ylabel(handles.axes4,tituloAmp);
axis(handles.axes4,[minRH maxRH minAmpH maxAmpH]);

minFasH = min(perfiles(:,4));
maxFasH = max(perfiles(:,4));
plot(handles.axes5,perfiles(:,1),perfiles(:,4));
title(handles.axes5,'Phase');
xlabel(handles.axes5,'Length (m)');
ylabel(handles.axes5,'Phase (rad)');
axis(handles.axes5,[minRH maxRH minFasH maxFasH]);

                         % Vertical %
minRV = min(perfiles(:,6));
maxRV = max(perfiles(:,6));
minAmpV = min(perfiles(:,7));
maxAmpV = max(perfiles(:,7));
plot(handles.axes6,perfiles(:,6),perfiles(:,7));
title(handles.axes6,'Amplitude');
xlabel(handles.axes6,'Length (m)');
ylabel(handles.axes6,tituloAmp);
axis(handles.axes6,[minRV maxRV minAmpV maxAmpV]);

minFasV = min(perfiles(:,9));
maxFasV = max(perfiles(:,9));
plot(handles.axes7,perfiles(:,6),perfiles(:,9));
title(handles.axes7,'Phase');
xlabel(handles.axes7,'Length (m)');
ylabel(handles.axes7,'Phase (rad)');
axis(handles.axes7,[minRH maxRH minFasV maxFasV]);

handles.output = hObject;
guidata(hObject, handles);

function varargout = Profiles_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
global perfiles
[fil,col] = size(perfiles);
P = cell(fil+2,9);
c = cell(2,4);
c(1,:) = {'Perfil Horizontal','Perfil Vertical','',''};
c(2,:) = {'r  (m)','Amplitude','ln(Amp)','Phase'};
P(1,1) = c(1,1);
P(1,6) = c(1,2);
for i=1:5:9
    P(2,i) = c(2,1);
    P(2,i+1) = c(2,2);
    P(2,i+2) = c(2,3);
    P(2,i+3) = c(2,4);
end
for f=1:1:fil
    for c=1:1:9
        P(f+2,c)=num2cell(perfiles(f,c));
    end
end
writecell(P,'Profiles_Horizontal_Vertical.xlsx')
msgbox("Profiles have been saved successfully","Save");    

function pushbutton2_Callback(hObject, eventdata, handles)
global   amp1 fas1 pend tituloAmp
Some_angles(amp1,fas1,pend,tituloAmp);

function pushbutton3_Callback(hObject, eventdata, handles)
global perfiles tituloAmp
cla(handles.axes4,'reset')
minRH = min(perfiles(:,1));
maxRH = max(perfiles(:,1));
minAmpH = min(perfiles(:,2));
maxAmpH = max(perfiles(:,2));
plot(handles.axes4,perfiles(:,1),perfiles(:,2));
title(handles.axes4,'Amplitude');
xlabel(handles.axes4,'Length (m)');
ylabel(handles.axes4,tituloAmp);
axis(handles.axes4,[minRH maxRH minAmpH maxAmpH]);

function pushbutton4_Callback(hObject, eventdata, handles)
global perfiles tituloAmp
cla(handles.axes4,'reset')
minRH = min(perfiles(:,1));
maxRH = max(perfiles(:,1));
minAmpH = min(perfiles(:,3));
maxAmpH = max(perfiles(:,3));
plot(handles.axes4,perfiles(:,1),perfiles(:,3));
title(handles.axes4,'Amplitude');
xlabel(handles.axes4,'Length  (m)');
ylabel(handles.axes4,tituloAmp);
axis(handles.axes4,[minRH maxRH minAmpH maxAmpH]);

function pushbutton5_Callback(hObject, eventdata, handles)
global perfiles tituloAmp
cla(handles.axes6,'reset')
minRV = min(perfiles(:,6));
maxRV = max(perfiles(:,6));
minAmpV = min(perfiles(:,7));
maxAmpV = max(perfiles(:,7));
plot(handles.axes6,perfiles(:,6),perfiles(:,7));
title(handles.axes6,'Amplitude');
xlabel(handles.axes6,'Length (m)');
ylabel(handles.axes6,tituloAmp);
axis(handles.axes6,[minRV maxRV minAmpV maxAmpV]);

function pushbutton6_Callback(hObject, eventdata, handles)
global perfiles tituloAmp
cla(handles.axes6,'reset')
minRV = min(perfiles(:,6));
maxRV = max(perfiles(:,6));
minAmpV = min(perfiles(:,8));
maxAmpV = max(perfiles(:,8));
plot(handles.axes6,perfiles(:,6),perfiles(:,8));
title(handles.axes6,'Amplitude');
xlabel(handles.axes6,'Length m()');
ylabel(handles.axes6,tituloAmp);
axis(handles.axes6,[minRV maxRV minAmpV maxAmpV]);
