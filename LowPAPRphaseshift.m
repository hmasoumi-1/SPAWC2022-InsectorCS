function P = LowPAPRphaseshift(zz,N)
MM=5000;
ZZ = (repmat(zz,1,MM)).*exp(1i*2*pi*rand([N,MM]));
U = myDFTmatrixGenerator(N);
PP = U*ZZ;
PAPR = (max(((abs(PP)).^2)))./(mean(((abs(PP)).^2)));
MinPAPR = find(PAPR == min(PAPR));
P = PP(:,MinPAPR);

end