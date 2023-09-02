function P = GreedyBeam(M,N,z_target_amp)

MM = 30*M;
p1 = (exp(1i*(2*rand(N,MM)-1)*pi))/sqrt(N);
U = myDFTmatrixGenerator(N);
z1_sector_of_interest = ((U')*p1).*repmat(sign(z_target_amp),1,MM);

InsectorEnergy = sum((abs(z1_sector_of_interest)).^2);

temp1 = sort(InsectorEnergy,'descend');

for itr = 1:M
    xx(itr) = find(InsectorEnergy == temp1(itr));
end
P = (p1(:,xx)).';
end