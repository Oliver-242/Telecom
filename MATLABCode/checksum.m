% checksum.m      
% calculating checksums with big- and little-endian ordering 
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Try this example with UseBigEndian set to false and then true');
%---------------------------------------------------------------

%---------------------------------------------------------------
% set calculation order to be big or little endian as desired
%UseBigEndian = false;
UseBigEndian = true;

pkthex = [  '45' '00' '00' '3C' ...
            '75' '02' '00' '00' ...
            '20' '01' '00' '00' ...    % checksum 00 00
            'AC' '10' '03' '01' ...    % 172.16.3.1
            'AC' '10' '03' '7E' ];     % 172.16.3.126

Nchars = length(pkthex);
cksm = 0;

for k = 1:4:Nchars - 1

    if( UseBigEndian )
        i = [k+0 k+1 k+2 k+3];    % big-endian
    else
        i = [k+2 k+3 k+0 k+1];    % little-endian
    end

    % convert string representing hex to decimal for calculations
    wordstr = pkthex(i);
    wordval = hex2dec(wordstr);

    cksm = cksm + wordval;
end

fprintf(1, 'Raw checksum %d decimal  %s hex\n', cksm, dec2hex(cksm));

% compute end-around carry
carry = floor(cksm/(2^16));
rem16 = cksm - carry*(2^16);
cksmea = rem16 + carry;

% complement
cksmnot = ((2^16) - 1) - cksmea;

fprintf(1, 'carry %s  cksm with carry %s  final cksm %s\n', ...
    dec2hex(carry), dec2hex(cksmea), dec2hex(cksmnot));
%---------------------------------------------------------------
