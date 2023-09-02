% Author: Hamed Masoumi
% Implementation of SPAWC2022 paper [In-sector 1D-CCS]
close all
clear all
clc
% -------------
% tic
I = 100;  % Number of monte-carlo simulations
Nr = 256; % Number of transmit antennas

DFT_angles = asin([2*(0:Nr/2)/Nr,-1+2*(1:(Nr/2-1))/Nr]);

M = 8;

SNR = [-7.5, -5, -2.5, 0, 2.5, 5, 7.5, 10];
Over_sampling = [1,4];
%%

for itr_res = 1:length(Over_sampling)
    
    n = Over_sampling(itr_res);

    Gr = n*Nr;
    t1 = 0:(Gr-1);
    t2 = 0:(Nr-1);

    T=(t2.')*t1;

    iDFTm = (1/sqrt(Nr))*exp(1i*2*pi*T/Gr);
        
    load('HH.mat');
    
    for itr_snr = 1:length(SNR)
        
        snr = SNR(itr_snr);
                
        disp(['snr = ', num2str(snr)])
        
        for itr_ch = 1:length(HH(1,:))
            h = HH(:,itr_ch);
        
            for mntcrlo = 1:I
            
            
                [Theta_start,Theta_end,zz,h_masked] = SLS(Nr,h);
                p_controlled = LowPAPRphaseshift(zz,Nr);
            
                DFT_angles_extended = asin([2*(0:Gr/2)/Gr,-1+2*(1:(Gr/2-1))/Gr]);
                x1_extended = ((Theta_start<=DFT_angles_extended)).';
                x2_extended = ((DFT_angles_extended<=Theta_end)).';
                zz_extended = x1_extended.*x2_extended;
    

            
                W_InSectorPaper = Ins(p_controlled, Nr, M);
            
                [W_SIb,W_SIbrnd] = SIb_and_Rnd(p_controlled,Nr,M,zz);
            
                W_Greedy = GreedyBeam(M,Nr,zz);

            
                
                A_InSectorPaper = W_InSectorPaper*iDFTm;
            
                A_SIb = W_SIb*iDFTm;
                A_SIbrnd = W_SIbrnd*iDFTm;
            
                A_Greedy = W_Greedy*iDFTm;
            
            
            % -------------
                SN = (randn(M,1) + 1j*randn(M,1))/sqrt(2);
                [y_InSectorPaper,np_InSectorPaper] = Noisy_Measurements(M,W_InSectorPaper,h,snr,SN);
                [y_SIb,np_SIb] = Noisy_Measurements(M,W_SIb,h,snr,SN);
                [y_SIbrnd,np_SIbrnd] = Noisy_Measurements(M,W_SIbrnd,h,snr,SN);
                [y_Greedy,np_Greedy] = Noisy_Measurements(M,W_Greedy,h,snr,SN);
            
            %% Run OMP                  
                xhat_InSectorPaper = myOMP_WO(A_InSectorPaper,y_InSectorPaper,zz_extended,np_InSectorPaper);
                hhat_InSectorPaper = iDFTm*xhat_InSectorPaper;
%                 channel_est_err_InSectorPaperTmp(mntcrlo,1) = (norm((h_masked-hhat_InSectorPaper)))^2;
                Rate_InSectorTmp(mntcrlo,1) = MyRate(hhat_InSectorPaper,h,snr);
                                
                xhat_SIb = myOMP_WO(A_SIb,y_SIb,zz_extended,np_SIb);
                hhat_SIb = iDFTm*xhat_SIb;
%                 channel_est_err_SIbTmp(mntcrlo,1) = (norm((h_masked-hhat_SIb)))^2;
                Rate_SIbTmp(mntcrlo,1) = MyRate(hhat_SIb,h,snr);
            
            
                xhat_SIbrnd = myOMP_WO(A_SIbrnd,y_SIbrnd,zz_extended,np_SIbrnd);
                hhat_SIbrnd = iDFTm*xhat_SIbrnd;
%                 channel_est_err_SIbrndTmp(mntcrlo,1) = (norm((h_masked-hhat_SIbrnd)))^2;
                Rate_SIbrndTmp(mntcrlo,1) = MyRate(hhat_SIbrnd,h,snr);
            
            
                xhat_Greedy = myOMP_WO(A_Greedy,y_Greedy,zz_extended,np_Greedy);
                hhat_Greedy = iDFTm*xhat_Greedy;
%                 channel_est_err_GreedyTmp(mntcrlo,1) = (norm((h_masked-hhat_Greedy)))^2;
                Rate_GreedyTmp(mntcrlo,1) = MyRate(hhat_Greedy,h,snr);
            
            
            end
%             h_normh_masked(itr_ch,1) = (norm(h_masked))^2;
            
%             channel_est_err_InSectorPaper(itr_ch,1) = mean(channel_est_err_InSectorPaperTmp);
            Rate_InSector(itr_ch,1) = mean(Rate_InSectorTmp);
            
%             channel_est_err_SIb(itr_ch,1) = mean(channel_est_err_SIbTmp);
            Rate_SIb(itr_ch,1) = mean(Rate_SIbTmp);
            
%             channel_est_err_SIbrnd(itr_ch,1) = mean(channel_est_err_SIbrndTmp);
            Rate_SIbrnd(itr_ch,1) = mean(Rate_SIbrndTmp);
            
%             channel_est_err_Greedy(itr_ch,1) = mean(channel_est_err_GreedyTmp);
            Rate_Greedy(itr_ch,1) = mean(Rate_GreedyTmp);
                
        end
        
%         nmse_temp2_InSectorPaper(itr_snr,itr_res) = mean(channel_est_err_InSectorPaper)/mean(h_normh_masked);
        RateInSector(itr_snr,itr_res) = mean(Rate_InSector);
        
%         nmse_temp2_SIb(itr_snr,itr_res) = mean(channel_est_err_SIb)/mean(h_normh_masked);
        RateSIb(itr_snr,itr_res) = mean(Rate_SIb);
        
%         nmse_temp2_SIbrnd(itr_snr,itr_res) = mean(channel_est_err_SIbrnd)/mean(h_normh_masked);
        RateSIbrnd(itr_snr,itr_res) = mean(Rate_SIbrnd);
        
%         nmse_temp2_Greedy(itr_snr,itr_res) = mean(channel_est_err_Greedy)/mean(h_normh_masked);
        RateGreedy(itr_snr,itr_res) = mean(Rate_Greedy);
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%

% nmse_SIb = 10*log10(nmse_temp2_SIb);
% nmse_SIbrnd = 10*log10(nmse_temp2_SIbrnd);
% nmse_InSectorPaper = 10*log10(nmse_temp2_InSectorPaper);
% nmse_Greedy = 10*log10(nmse_temp2_Greedy);

% save nmse.mat nmse_SIb nmse_SIbrnd nmse_InSectorPaper nmse_Greedy
save Over_sampling.mat Over_sampling
% save MM.mat MM
save SNR.mat SNR
save Rate.mat RateSIb RateSIbrnd RateGreedy RateInSector
% toc
% load handel
% sound(y,Fs)