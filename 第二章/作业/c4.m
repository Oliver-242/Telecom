% fbreg.m 
% feedback register
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
B = 4;               % bits in shift register
sregin = uint8(11);  % shift register seed.  11 dec = 1011 bin
creg = uint8(11);    % connection register. 9 dec = 1001 bin
MSBmask = uint8(08); % binary 1000
LSBmask = uint8(01); % binary 0001

sreg = uint8(sregin);
fprintf(1, 'start: sreg=%s (%d)\n', dec2bin(sreg, B), sreg);

ssave = [];
NS = 20;

for t = 1:NS
    ssave = [ssave sreg];

    % select rightmost bit of shift register
    M = LSBmask;
    ssreg = bitand( bitand(sreg, creg), M);
    freg = ssreg;

    for b = 2:B
        M = bitshift(M, 1);
        ssreg = bitand(sreg, creg);

        tmpreg = bitxor( bitshift(freg,1), ssreg );
        tmpreg = bitand(tmpreg, M);

        freg = bitor(freg, tmpreg);
    end

    % main shift register shifted right and OR in MSB
    sreg = bitor(bitshift(sreg, -1), bitand(freg, MSBmask));

    fprintf(1, 'after: sreg=%s (%d)\n', dec2bin(sreg, B), sreg);
end
fprintf(1, 'Sequence: (%d terms) ', NS);
fprintf(1, 'seed %s  connection %s\n', dec2bin(sregin, B), dec2bin(creg, B));
fprintf(1, '%d ', ssave);
fprintf(1, '\n');
%---------------------------------------------------------------