% remove menu bar, give it a title/caption, and 
% remove "Figure N" 
% Usage:
%   figtitle(figtext, fighandle)
% figtext = figure title text
% [fighandle] = figure handle (optional)
% 
%---------------------------------------------------------------
function figtitle(figtext, fighandle)
%---------------------------------------------------------------

%---------------------------------------------------------------
if( nargin == 1 )
    % default to current figure, if no figure handle given 
    fighandle = gcf;
end
%---------------------------------------------------------------

%---------------------------------------------------------------
% remove menu bar
set(fighandle, 'MenuBar', 'none');

% change figure title bar 
set(fighandle, 'Name', figtext);

% remove string 'Figure 1' from title bar
set(fighandle, 'NumberTitle', 'off');
%---------------------------------------------------------------

