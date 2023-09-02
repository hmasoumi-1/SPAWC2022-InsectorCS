function DFTm = myDFTmatrixGenerator(N)

t = 0:(N-1);

T=(t.')*t;

DFTm = (1/sqrt(N))*exp(-1i*2*pi*T/N);

end