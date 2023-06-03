% IntValue.m 
% declaring a class with by-value
%---------------------------------------------------------------

%---------------------------------------------------------------
% put in file IntValue.m
%---------------------------------------------------------------

%---------------------------------------------------------------
classdef IntValue
    properties
        TheValue = 0;
    end

    methods
        % constructor
        function [IntValueObject] =  IntValue(val)
            IntValueObject.TheValue = val;
        end
    end
end
%---------------------------------------------------------------
