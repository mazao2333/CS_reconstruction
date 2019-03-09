%define M & N of ¦µ
M = floor(height/4);
% ¦µ keep one third of the original data
% M>=S*log(N/S)¡­¡­?
N = height;

%measurement matrix: ¦µ
Phi = randn(M,N);   
Phi = Phi/sqrt(M);
%Phi = Phi./repmat(sqrt(sum(Phi.^2,1)),[M,1]); % normalize each column

%base matrix: ¦·
Psi = fft(eye(height))/sqrt(height);
% building the DFT basis (corresponding to each column)

%¦¨
Theta = Phi * Psi;