function xhat = myOMP_WO(A,y,zzz,np)

AA = [];
r=zeros(length(y),1);
dd=length(A(1,:));
y_orig=y;
M = length(y);
eps2 = M*np;
err(1) = 10*eps2;
itr=1;
Sector_indices = find(zzz);
if norm(y_orig) ~= 0
    while ((err >= eps2) && (itr<=(M)))
    
            tmp1 = abs(A'*y);
            
    % --------------------------------------
        tmp2 = tmp1(Sector_indices,1);
        if length(find(max(tmp2)==tmp2))>1
            zz = find(max(tmp2)==tmp2);   % If this happens it means that OMP is unable to recover
            ind_max(itr) = Sector_indices(zz(1));
        else
            ind_max(itr) = Sector_indices(find(max(tmp2)==tmp2));
        end        
        
        AA = [AA,A(:,ind_max(itr))];
    
        xhat1 = (inv((AA'*AA)))*AA'*y_orig;
    
        r = y_orig - AA*xhat1;
            
        err = (norm(r))^2;    % Stopping criterion based on noise level (eps2)

        y=r;
        
        itr = itr + 1;
    end
    
    xhat = zeros(length(A(1,:)),1);
    for itr1 = 1:length(ind_max)
        xhat(ind_max(itr1),1) = xhat1(itr1);
    end
    
else
    
    xhat = zeros(length(A(1,:)),1);
end

end
