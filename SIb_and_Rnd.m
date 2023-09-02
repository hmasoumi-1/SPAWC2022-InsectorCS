function [W,W_rnd] = SIb_and_Rnd(p_controlled,N,M,zz)

%% SIB
D1D2 = sum(~zz);

% Py = N - (D1 + D2);    % Amplitude of DFT of "b" should be periodic with period Py where all entries are zero except for one of them
Py = N - D1D2;
Px = N/Py;   %   Period of Py in frequency domain translates into period of Px in time domain
    
Omega_ideal = (1:Px:N).';

Omega_sib = sort(Omega_ideal(randperm(length(Omega_ideal),M),1));   % Selecting M random indices from non-zero indices in ideal indices sampling
    
    
P = PhaseShiftMatrix(p_controlled,Omega_sib);

W = P.';


%% Random sampling
Omega_rnd = randperm(N,M);
    
P_rnd = PhaseShiftMatrix(p_controlled,Omega_rnd);

W_rnd = P_rnd.';

end