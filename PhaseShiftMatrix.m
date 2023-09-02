function P = PhaseShiftMatrix(P_base,CircularShifts)

P = [];

for itr = 1:length(CircularShifts)
    tmp = circshift(P_base,CircularShifts(itr));
    P = [P,tmp];
end

end