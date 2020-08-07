close all;
clear all;
rng('shuffle');

SNRdB = [1:0.5:13];
blockLength = 1000000;
bits = randi([0,1],[1,blockLength]);
BER = zeros(size(SNRdB));
ChNoise = (randn(1,blockLength)+j*randn(1,blockLength));
for K=1:length(SNRdB)
SNR=10^(SNRdB(K)/10);
Txbits = sqrt(SNR)*(2*bits-1);
Rxbits = Txbits + ChNoise;
DecodedBits = ((real(Rxbits))>=0);
BER(K)= sum(DecodedBits~=bits)/blockLength;
end
semilogy(SNRdB,BER,'b s','linewidth',2.0);
hold on;
semilogy(SNRdB,qfunc(sqrt(10.^(SNRdB/10))),'r-.','linewidth',2.0);
axis tight;
grid on;
legend('AWGN','Theory')
xlabel('SNR(dB)');
ylabel('BER');
title('BER vs SNR(dB)');
