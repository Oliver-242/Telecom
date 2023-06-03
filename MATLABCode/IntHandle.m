% IntHandle.m 
% declaring a class with by-reference (handle)
%---------------------------------------------------------------

%---------------------------------------------------------------
% put in file IntHandle.m
%---------------------------------------------------------------

%---------------------------------------------------------------
classdef IntHandle < handle
    properties
        TheValue = 0;
    end

   methods
        % constructor
        function [IntValueObject] =  IntHandle(val)
            IntValueObject.TheValue = val;
        end
   end
end
%---------------------------------------------------------------
