% PacketClass.m   
% declaring a data object of a certain class 
% put in file PacketClass.m
%---------------------------------------------------------------

%---------------------------------------------------------------
classdef PacketClass            % value (by-value) class - refer text
%classdef PacketClass < handle  % handle (by-reference) class - refer text
    properties
        status = 'unknown';
        ByteLength = 0;
    end

    methods
        % constructor
        function PacketObject =  PacketClass(InitStatus, InitLength)
            disp('Calling the constructor for PacketClass');
            PacketObject.status = InitStatus;
            PacketObject.ByteLength = InitLength;
        end

        % show contents
        function Show(PacketClassObject)
            fprintf(1, 'Packet status is "%s"\n', ...
            		PacketClassObject.status);
            fprintf(1, 'Packet length is "%d"\n', ...
            		PacketClassObject.ByteLength);
        end

        function [ReturnedObject] = UpdateLength(PacketClassObject)
            % Note that this does change the original object's data if
            % declared normally. Could return the object from this
            % function, or declare the class as by-reference using
            % classdef PacketClass < handle
            PacketClassObject.ByteLength = 100;
            
            % returns a new object 
            ReturnedObject = PacketClassObject;
        end
    end
end
%---------------------------------------------------------------
