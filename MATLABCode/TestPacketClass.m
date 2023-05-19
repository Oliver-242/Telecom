% TestPacketClass.m 
% test the class PacketClass
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Note: you should try this example twice:');
disp('In PacketClass.m using the declaration:');
disp('    classdef PacketClass            % value (by-value) class - refer text');
disp('and also using the declaration:');
disp('    classdef PacketClass < handle  % handle (by-reference) class - refer text');
disp('The output will be slightly different, and the difference is important.');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
FirstPacket = PacketClass('Ready', 32);

% conventional disp() method
disp(FirstPacket);

% show method - can invoke two ways 
Show(FirstPacket);
FirstPacket.Show();

% try to change the length field 
FirstPacket.ByteLength = 64;

% invoke as object.method() - object passed as first parameter
FirstPacket.UpdateLength();

% invoke using method(object)
UpdateLength(FirstPacket);

FirstPacket.Show();

SecondPacket = FirstPacket.UpdateLength();
FirstPacket.Show();
SecondPacket.Show();
%---------------------------------------------------------------
