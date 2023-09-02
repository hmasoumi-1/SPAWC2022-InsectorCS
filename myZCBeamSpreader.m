function Delta = myZCBeamSpreader(SF,N)

Nc = N*SF;

if mod(Nc,2)==0
    
    tau = 3;   % Has to be coprime with Nc. Here we assumed Nc = 2^m
    Alpha = exp(-1j*pi*tau*(((0:(Nc-1)).').^2)/Nc);
    Delta = diag(repelem(Alpha,1/SF,1));
    
else
    
    disp('Nc is odd it seems something is wrong')
    
end

end