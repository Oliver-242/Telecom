% FourierSynth.m
% Synthesize a Fourier Series interactively
%---------------------------------------------------------------

%---------------------------------------------------------------
% actually a script, but denote as a function so we can use 
% embedded callback function
function FourierSynth()

    %---------------------------------------------------------------
    clear all
    close all
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    global F0;
    global Ak;
    global Bk;
    global NumFreq;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    global hSliderAk;
    global hSliderAkText;
    global hSliderBk;
    global hSliderBkText;

    global hSliderF0Text;
    %---------------------------------------------------------------


    %---------------------------------------------------------------
    global Fs;
    global NBuf;
    global AudioBuf;
    global Player;
    global Running;
    %---------------------------------------------------------------
        
    %---------------------------------------------------------------
    Setup();
    DrawScreen();
    GenWave();
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    % close figures and stop callbacks on ctrl-c
    onCleanup( @()  cleanup() );
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    CreateAudioPlayer();
    StartAudioPlayer();
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    while( Running )
    
        fprintf(1, 'Running\n');
        
        %if( ~Player.isplaying() )
        %    Player.play();
        %end

        %---------------------------------------------------------------
        %play(Player);
        %---------------------------------------------------------------
    
        pause(1);
    end
    %---------------------------------------------------------------
        
    %---------------------------------------------------------------
    %for k = 1:10
        %k
        %if( ~Player.isplaying() )
        %    Player.play()
        %end
        %pause(0.5)
    %end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    % Player.stop() works in 2013- versions, but not 2010. 
    % For version where this does not work, stop(Player) works.
    %Player.stop();
    stop(Player);
    close('all');
    %---------------------------------------------------------------
    

end
%---------------------------------------------------------------

%---------------------------------------------------------------
function GenWave()

    %---------------------------------------------------------------
    global Fs;
    global NBuf;
    global AudioBuf;
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    global NumFreq;
    
    global F0;
    global Ak;
    global Bk;
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    % new matlab line colors
    mcnew = [ ...
        0         0.4470    0.7410 ; ...
        0.8500    0.3250    0.0980 ; ...
        0.9290    0.6940    0.1250 ; ...
        0.4940    0.1840    0.5560 ; ...
        0.4660    0.6740    0.1880 ; ...
        0.3010    0.7450    0.9330 ; ...
        0.6350    0.0780    0.1840 ; ...
    ];
    %---------------------------------------------------------------


    %---------------------------------------------------------------
    fprintf(1, 'GenWave()\n');
    
    N = NBuf;
    %f = F0;
    %A = Ak;
    
    %w = (2*pi*f)*(1/Fs);
    n = 0:N-1;
    %x = A*sin(n*w);
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    hPlotWin = figure(2);
    clf;
    set(hPlotWin, 'Position', [655 50 300 650]);

    % remove menu bar
    set(hPlotWin, 'MenuBar', 'none', 'color', [0.8 0.8 0.8]);

    % change figure title bar and remove string 'Figure 2'
    set(hPlotWin, 'Name', 'Fourier Components and Result');
    set(hPlotWin, 'NumberTitle', 'off');
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    NPlot = 400;
    x = zeros(N, 1);
    for FreqNum = 1:NumFreq
        A = Ak(FreqNum);
        B = Bk(FreqNum);
        
        f = F0*FreqNum;
        w = (2*pi*f)*(1/Fs);
        
        xc = A*cos(n*w);
        xc = xc(:);

        yc = B*sin(n*w);
        yc = yc(:);

        subplot(NumFreq+1, 1, FreqNum);
        k = 1:NPlot;
        %plot(k, xc(k), 'b', k, yc(k), 'r', 'linewidth', 2);
        %plot(k, xc(k), 'color', mcnew(1,:), k, yc(k), 'color', mcnew(2,:), 'linewidth', 2);
        h = plot(k, xc(k), k, yc(k));
        set(h(1), 'Color', mcnew(3,:), 'LineWidth', 2);
        set(h(2), 'Color', mcnew(4,:), 'LineWidth', 2);
        
        set(gca, 'ylim', [-2 2]);
        set(gca, 'ytick', []);
        set(gca, 'xtick', []);
        
        x = x + (xc + yc);
    end
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    subplot(NumFreq+1, 1, NumFreq+1);
    %plot(x(1:NPlot), 'm', 'linewidth', 2);
    h = plot(x(1:NPlot));
    set(h, 'Color', mcnew(2,:), 'LineWidth', 2);
    
    set(gca, 'ylim', [-4 4]);
    set(gca, 'ytick', []);
    set(gca, 'xtick', []);
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    % save in global
    AudioBuf = x(:);
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

    
%---------------------------------------------------------------
function Setup()
    
    %---------------------------------------------------------------
    global Fs;
    global NBuf;
    global AudioBuf;
    global Tmax;

    global Player;
    global Running;    
    
    global NumFreq;
    global F0;
    global Ak;
    global Bk;
    
    global hSliderAk;
    global hSliderAkText;
    global hSliderBk;
    global hSliderBkText;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    NumFreq = 8;

    hSliderAk = zeros(NumFreq, 1);
    hSliderAkText = zeros(NumFreq, 1);
    Ak = zeros(NumFreq, 1);
    Ak(1) = 1;

    hSliderBk = zeros(NumFreq, 1);
    hSliderBkText = zeros(NumFreq, 1);
    Bk = zeros(NumFreq, 1);
    Bk(1) = 0;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    Fs = 48000;
    %Fs = 8000;
    NBuf = 1*Fs;
    
    F0 = 400;
    %Ak = 1;
    %---------------------------------------------------------------
    
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function CreateAudioPlayer()
    %---------------------------------------------------------------
    global Fs;
    global NBuf;
    global AudioBuf;
    global Player;
    global F0;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    TimerPeriod = NBuf/Fs;
    %---------------------------------------------------------------

    
    %---------------------------------------------------------------
    Player = audioplayer(AudioBuf, Fs);
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    %TimerPeriod = 0.8*TimerPeriod;
    %Player.TimerPeriod = TimerPeriod;
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    % this seems to work in some versions
    %Player.TimerFcn = 'AudioTimerCallback';
    
    % but this is correct
    %Player.TimerFcn = @AudioTimerCallback;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    Player.StartFcn = @AudioStartCallback;
    Player.StopFcn = @AudioStopCallback;
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function StartAudioPlayer()
    %---------------------------------------------------------------
    global Fs;
    global NBuf;
    global AudioBuf;
    global Player;
    global Running;
    %---------------------------------------------------------------
    
    fprintf(1, 'StartAudioPlayer()\n');
    
    %---------------------------------------------------------------
    Running = true;
    
    % Player.play() works in 2013- versions, but not 2010. 
    % For version where this does not work, play(Player) works.
    %Player.play();
    play(Player);
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% to work in all versions, must declare the object and event passed 
% appears to be related to passing an arg to main function, which should 
% be totally unrelated
%function EmbeddedRealTimeFFTTimerFcn()
function AudioTimerCallback(hObject, eventdata)
    %---------------------------------------------------------------
    global Player;
    global Running;
    %---------------------------------------------------------------

    fprintf(1, 'Timer Callback\n');
    
    %---------------------------------------------------------------
    %Player.stop();
    %GenWave();
    %Player.isplaying()
    
    %Player.TimerPeriod = TimerPeriod;
    %
    %Player.play();
    %---------------------------------------------------------------
    
    %Player.stop();
    
    %---------------------------------------------------------------
    if( Running )
        CreateAudioPlayer();
        StartAudioPlayer();
    end
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function AudioStartCallback(hObject, eventdata)
    %---------------------------------------------------------------
    global Player;
    %---------------------------------------------------------------

    fprintf(1, 'Start Callback\n');
    
    %---------------------------------------------------------------
    %Player.stop();
    %GenWave();
    %Player.isplaying()
    
    %Player.TimerPeriod = TimerPeriod;
    %
    %Player.play();
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function AudioStopCallback(hObject, eventdata)
    %---------------------------------------------------------------
    global Player;
    global Running;
    %---------------------------------------------------------------

    fprintf(1, 'Stop Callback\n');
    
    %---------------------------------------------------------------
    %Player.stop();
    %GenWave();
    %Player.isplaying()
    
    %Player.TimerPeriod = TimerPeriod;
    %
    %Player.play();
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    % works but has audible gaps
    if( Running )
        CreateAudioPlayer();
        StartAudioPlayer();
    end
    %---------------------------------------------------------------
end
%---------------------------------------------------------------


%---------------------------------------------------------------
function DrawScreen()

    %---------------------------------------------------------------
    global NumFreq;

    global F0;
    global Ak;
    global Bk;

    global hSliderAk;
    global hSliderAkText;

    global hSliderBk;
    global hSliderBkText;
    
    global hSliderF0Text;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    hMenuWin = figure(1);
    clf;
    set(hMenuWin, 'Position', [10 50 630 250]);

    % remove menu bar
    set(hMenuWin, 'MenuBar', 'none', 'color', [0.8 0.8 0.8]);

    % change figure title bar and remove string 'Figure 1'
    set(hMenuWin, 'Name', 'Fourier Synthesizer');
    set(hMenuWin, 'NumberTitle', 'off');
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    hPb1 = uicontrol(hMenuWin, 'style', 'push', ...
                               'position', [10 210 100 20], ...
                               'string', 'Exit',...
                               'callback', @ExitCallback);

    hPb2 = uicontrol(hMenuWin, 'style', 'push', ...
                               'position', [10 180 100 20],...
                               'string', 'Reset', ...
                               'callback', @ResetCallback);
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    % fundamental, F0
    % note changes in function-file callback
    % precede with @, no '' quotes, no argument list
    hSliderF0 = uicontrol(hMenuWin, 'style', 'slider', ...
                               'position',[10 120 100 16], ...
                               'callback', @SliderF0Callback);
                                %'callback', 'SliderCallback(hSlider, 0, hSliderText)');

    Fmax = 2000;
    Fmin = 20;
    Fstep = 10;
    
    set(hSliderF0, 'max', Fmax);
    set(hSliderF0, 'min', Fmin);
    set(hSliderF0, 'value', F0);

    % set slider step multipliers as a fraction of fullscale 
    set(hSliderF0, 'SliderStep', [0.1 1]*(Fstep/(Fmax - Fmin)));
    
    hTextF0 = uicontrol(hMenuWin, 'style', 'text', ...
                               'position',[20 100 80 12], ...
                               'string', 'Frequency F0', 'HorizontalAlignment', 'center');

    hSliderF0Text = uicontrol(hMenuWin, 'style','edit', ...
                               'position', [20 80 70 12], ...
                               'string', 'create', 'HorizontalAlignment', 'center');

    % don't use 'default', does not work!
    buf = sprintf('%.0f', F0);
    set(hSliderF0Text, 'string', buf);
    %set(hSliderText, 'string', 'thedefault');
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    % amplitude of each component
    Amax = 2;
    Amin = -2;
    Astep = 0.1;

    xpos = 120;
    for FreqNum = 1:NumFreq
        
        %---------------------------------------------------------------
        % Ak - cosine components
        % note changes in function-file callback
        % precede with @, no '' quotes, no argument list
        hSliderAk(FreqNum) = uicontrol(hMenuWin, 'style', 'slider', ...
                                   'position', [xpos 50 20 150], ...
                                   'callback', @SliderAkCallback);
                                    %'callback', 'SliderCallback(hSlider, 0, hSliderText)');

                                    
        set(hSliderAk(FreqNum), 'max', Amax);
        set(hSliderAk(FreqNum), 'min', Amin);
        set(hSliderAk(FreqNum), 'value', Ak(FreqNum));

        % set slider step multipliers as a fraction of fullscale 
        set(hSliderAk(FreqNum), 'SliderStep', [0.1 1]*Astep/(Amax - Amin));
        
        % save component number in user data field for callback 
        set(hSliderAk(FreqNum), 'UserData', FreqNum);

        %buf = sprintf('A%.0f', FreqNum-1);
        buf = sprintf('A%.0f', FreqNum);
        hTextAk(FreqNum) = uicontrol(hMenuWin, 'style', 'text', ...
                                   'position', [xpos 30 20 12], ...
                                   'string', buf, 'HorizontalAlignment', 'center');

        hSliderAkText(FreqNum) = uicontrol(hMenuWin, 'style', 'edit', ...
                                   'position', [xpos-6 205 30 12], ...
                                   'string', 'val', 'HorizontalAlignment', 'center');
                               %'FontSize', 7);
        buf = sprintf('%.2f', Ak(FreqNum));
        set(hSliderAkText(FreqNum), 'string', buf);
        %---------------------------------------------------------------

        %---------------------------------------------------------------
        % Bk - sine components
        % note changes in function-file callback
        % precede with @, no '' quotes, no argument list
        hSliderBk(FreqNum) = uicontrol(hMenuWin, 'style', 'slider', ...
                                   'position', [xpos+25 50 20 150], ...
                                   'callback', @SliderBkCallback);
                                    %'callback', 'SliderCallback(hSlider, 0, hSliderText)');

                                    
        set(hSliderBk(FreqNum), 'max', Amax);
        set(hSliderBk(FreqNum), 'min', Amin);
        set(hSliderBk(FreqNum), 'value', Bk(FreqNum));

        % set slider step multipliers as a fraction of fullscale 
        set(hSliderBk(FreqNum), 'SliderStep', [0.1 1]*Astep/(Amax - Amin));
        
        % save component number in user data field for callback 
        set(hSliderBk(FreqNum), 'UserData', FreqNum);

        %buf = sprintf('B%.0f', FreqNum-1);
        buf = sprintf('B%.0f', FreqNum);
        hTextBk(FreqNum) = uicontrol(hMenuWin, 'style', 'text', ...
                                   'position', [xpos+25 30 20 12], ...
                                   'string', buf, 'HorizontalAlignment', 'center');

        hSliderBkText(FreqNum) = uicontrol(hMenuWin, 'style', 'edit', ...
                                   'position', [xpos-6+28 205 30 12], ...
                                   'string', 'val', 'HorizontalAlignment', 'center');

        buf = sprintf('%.2f', Bk(FreqNum));
        set(hSliderBkText(FreqNum), 'string', buf);
        %---------------------------------------------------------------
        
        %---------------------------------------------------------------
        xpos = xpos + 65;
        %---------------------------------------------------------------
    end
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    %hPb15 = uicontrol(hMenuWin, 'style','push', ...
    %                           'position',[20 20 150 20], ...
    %                           'string', 'Exit', ...
    %                           'callback', 'close all');
    %---------------------------------------------------------------
end
%---------------------------------------------------------------


%---------------------------------------------------------------
function    SliderF0Callback(hObject, eventdata)

    %---------------------------------------------------------------
    global hSliderF0Text;
    global F0;
    %---------------------------------------------------------------

    %get(hObject)
    
    %---------------------------------------------------------------
    SliderPos = get(hObject, 'Value');
    fprintf(1, 'Slider Position=%f\n', SliderPos);

    buf = sprintf('%.0f', SliderPos);
    set(hSliderF0Text, 'string', buf);
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    F0 = SliderPos;
    GenWave();
    %---------------------------------------------------------------

end
%---------------------------------------------------------------

%---------------------------------------------------------------
function    SliderAkCallback(hObject, eventdata)

    %---------------------------------------------------------------
    global NumFreq;

    global hSliderAk;
    global hSliderAkText;
    global Ak;
    %---------------------------------------------------------------

    %get(hObject)
    %pause

    %---------------------------------------------------------------
    FreqNum = get(hObject, 'UserData');
    fprintf(1, 'Callback Ak for frequency %d\n', FreqNum);
    %---------------------------------------------------------------

    
    %---------------------------------------------------------------
    %if( hObject == hSliderAk )
    %    fprintf(1, 'Found Object\n');
    %else
    %    fprintf(1, 'Not this Object\n');
    %end
    %---------------------------------------------------------------
    

    %---------------------------------------------------------------
    SliderPos = get(hObject, 'Value');
    fprintf(1, 'Slider Ak Position=%f\n', SliderPos);
    Ak(FreqNum) = SliderPos;

    buf = sprintf('%.2f', Ak(FreqNum));
    set(hSliderAkText(FreqNum), 'string', buf);
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    GenWave();
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function    SliderBkCallback(hObject, eventdata)

    %---------------------------------------------------------------
    global NumFreq;

    global hSliderBk;
    global hSliderBkText;
    global Bk;
    %---------------------------------------------------------------

    %get(hObject)
    %pause

    %---------------------------------------------------------------
    FreqNum = get(hObject, 'UserData');
    fprintf(1, 'Callback Bk for frequency %d\n', FreqNum);
    %---------------------------------------------------------------

    
    %---------------------------------------------------------------
    %if( hObject == hSliderAk )
    %    fprintf(1, 'Found Object\n');
    %else
    %    fprintf(1, 'Not this Object\n');
    %end
    %---------------------------------------------------------------
    

    %---------------------------------------------------------------
    SliderPos = get(hObject, 'Value');
    fprintf(1, 'Slider Bk Position=%f\n', SliderPos);
    Bk(FreqNum) = SliderPos;

    buf = sprintf('%.2f', Bk(FreqNum));
    set(hSliderBkText(FreqNum), 'string', buf);
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    GenWave();
    %---------------------------------------------------------------
end
%---------------------------------------------------------------


%---------------------------------------------------------------
% ExitCallback.m
% for inline functions, must have these parameters
% Calls TextCode when either the button is pressed or the user hits enter
% in the text entry box. 
function ExitCallback(hObject, eventdata)

    global hEditWin;
    global Running;
        
    % toggle
    if( Running )
        fprintf(1, 'Stop running\n');
        Running = false;
    end
    
    if 0
    DefaultString = 'a default string';

    hLoadFig = figure(3);
    set(hLoadFig, 'position', [300 200 320 100], 'menu', 'none');

    hEditWin = uicontrol(hLoadFig, 'style', 'edit', ...
                                   'string', DefaultString,...
                                   'position', [10 10 300 20],...
                                   'callback', @TextCode);
    hEditPb = uicontrol(hLoadFig, 'style', 'push', ...
                                  'position', [10 60 300 30], ...
                                  'string', 'Call TextCode()', ...
                                  'callback', @TextCode);
    end
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% ResetCallback.m
% for inline functions, must have these parameters
% Calls TextCode when either the button is pressed or the user hits enter
% in the text entry box. 
function ResetCallback(hObject, eventdata)
    global NumFreq;
    global F0;
    global Ak;
    global Bk;
    
    global hSliderAk;
    global hSliderAkText;
    global hSliderBk;
    global hSliderBkText;
    %---------------------------------------------------------------

    fprintf(1, 'Reset Callback\n');
    
    %---------------------------------------------------------------
    %NumFreq = 8;

    Ak = zeros(NumFreq, 1);
    Ak(1) = 1;

    Bk = zeros(NumFreq, 1);
    Bk(1) = 0;
    %---------------------------------------------------------------

    %---------------------------------------------------------------
    F0 = 400;
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    for FreqNum = 1:NumFreq
        set(hSliderAk(FreqNum), 'value', Ak(FreqNum));
        buf = sprintf('%.2f', Ak(FreqNum));
        set(hSliderAkText(FreqNum), 'string', buf);
        
        set(hSliderBk(FreqNum), 'value', Bk(FreqNum));
        buf = sprintf('%.2f', Bk(FreqNum));
        set(hSliderBkText(FreqNum), 'string', buf);
    end    
    %---------------------------------------------------------------
    
    %---------------------------------------------------------------
    GenWave();
    %---------------------------------------------------------------
end
%---------------------------------------------------------------

%---------------------------------------------------------------
function TextCode(hObject, eventdata)

    global hEditWin;

    UserString = get(hEditWin, 'string');

    fprintf(1, 'the user string is ''%s''\n', UserString);
    num = sscanf(UserString, '%f');
    if( isempty(num) )
       fprintf(1, 'could not convert this to a number\n\n');
    else
       fprintf(1, 'As a number, this is %f\n\n', num);
    end
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% for cleaning up on ctrl-c
% when the main function goes out of scope, remove windows
% also stop callbacks
function cleanup()
    close all;
    clear all; 
end
%---------------------------------------------------------------




