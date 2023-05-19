% StructExamp.m 
% example of how to declare structures
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
% one method 
PacketStruct.status = 'good';
PacketStruct.ByteLength = 1024;

disp(PacketStruct)

class(PacketStruct)

fieldnames(PacketStruct)
%---------------------------------------------------------------

%---------------------------------------------------------------
% another method 
PacketStruct2 = struct('status', 'bad', 'ByteLength', 4096);

disp(PacketStruct2)

class(PacketStruct2)

fieldnames(PacketStruct2)
%---------------------------------------------------------------

%---------------------------------------------------------------
% Note that the above will give an output mentioning 'cells'
% Cell arrays in MATLAB allow variable-length data, for example
% the following will give an error that the matrix dimensions are
% inconsistent (try it)
% MyData = [ 'one' ; 'two' ; 'three' ];
%

MyData = { 'one' ; 'two' ; 'three' };
MyData

% and we can retrieve the third string as 
s = char(MyData(3));
s
%---------------------------------------------------------------
