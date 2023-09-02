function [y,np] = Noisy_Measurements(M,W,h,snr,SN)

y_nl = W*h;   % Noiseless measurements
        
np = ((norm(y_nl))^2)/(M*10^(snr/10));   % power of noise
        
noise = (sqrt(np))*SN;
        
y = y_nl + noise;            
            
end