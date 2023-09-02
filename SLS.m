function [Theta_start,Theta_end,zz,h_masked] = SLS(Nr,h)

DFT_angles = asin([2*(0:Nr/2)/Nr,-1+2*(1:(Nr/2-1))/Nr]);


Theta_start1 = DFT_angles(2);
Theta_end1 = DFT_angles(Nr/4 + 2); % = pi/6 if Nr = 256
indicator1 = (Theta_start1<=DFT_angles).*(DFT_angles<Theta_end1);
if sum(indicator1) ~= 0
   E1 = sum((abs((indicator1.').*fft(h))).^2);
else
    E1 = 0;
end


Theta_start2 = DFT_angles(Nr/4 + 2);
Theta_end2 = DFT_angles(Nr/2 + 1); % = pi/2 if Nr = 256
indicator2 = (Theta_start2<=DFT_angles).*(DFT_angles<=Theta_end2);
if sum(indicator2) ~= 0
   E2 = sum((abs((indicator2.').*fft(h))).^2);
else
    E2 = 0;
end    


Theta_start3 = DFT_angles(Nr/2 + 2);
Theta_end3 = DFT_angles(3*Nr/4 + 2);
indicator3 = (Theta_start3<=DFT_angles).*(DFT_angles<Theta_end3);
if sum(indicator3) ~= 0
   E3 = sum((abs((indicator3.').*fft(h))).^2);
else
    E3 = 0;
end


Theta_start4 = DFT_angles(3*Nr/4 + 2);
Theta_end4 = 0;
indicator4 = (Theta_start4<=DFT_angles).*(DFT_angles<=Theta_end4);
if sum(indicator4) ~= 0
   E4 = sum((abs((indicator4.').*fft(h))).^2);
else
    E4 = 0;
end

out1 = [E1,E2,E3,E4];
max_sector = find(out1 == max(out1));
switch max_sector
    case 1
        Theta_start = Theta_start1;
        Theta_end = Theta_end1;
        h_masked = ifft((indicator1.').*fft(h));
        zz = indicator1.';
    case 2
        Theta_start = Theta_start2;
        Theta_end = Theta_end2;
        h_masked = ifft((indicator2.').*fft(h));
        zz = indicator2.';
    case 3
        Theta_start = Theta_start3;
        Theta_end = Theta_end3;
        h_masked = ifft((indicator3.').*fft(h));
        zz = indicator3.';
    case 4
        Theta_start = Theta_start4;
        Theta_end = Theta_end4;
        h_masked = ifft((indicator4.').*fft(h));
        zz = indicator4.';
end


end