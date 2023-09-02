function R = MyRate(hhat,h,snr)
hhat_normalized = hhat/norm(hhat);
%y_nl = ((hhat_normalized)')*(h/norm(h));   % Noiseless measurements (Normalized h)
y_nl = ((hhat_normalized)')*(h);   % Noiseless measurements
        
np = 1/(10^(snr/10));   % power of noise
% np = ((norm(y_nl))^2)/(10^(snr/10));   % power of noise
        
R = log2(1 + ((norm(y_nl))^2)/np);

end