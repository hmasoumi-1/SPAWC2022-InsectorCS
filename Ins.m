function w_sectored = Ins(P, N, M)

Theta1 = -pi/12;
Theta2 = pi/12- pi/(N/2);  % So that number of entries in the sector be the same for all sectors
DFT_angles = asin([2*(0:N/2)/N,-1+2*(1:(N/2-1))/N]);
xx1 = ((Theta1<=DFT_angles)).';
xx2 = ((DFT_angles<=Theta2)).';
zz = xx1.*xx2;

DFT_column_indices = (1:N).';

xx = zz.*DFT_column_indices;

xx(find(xx==0)) = [];

Selected_DFT_columns = xx(randperm(length(xx),M));
Selected_DFT_beams = zeros(N,M);
U = myDFTmatrixGenerator(N);
for itr = 1:M
    Selected_DFT_beams(:,itr) = U(:,Selected_DFT_columns(itr));
end

Delta = diag(P);

w_sectored = (Delta*Selected_DFT_beams).';

end