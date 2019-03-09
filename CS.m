% -------------------init-------------------
clear;

% read image
img = imread('test_image/lena.bmp');
img = double(img);
[height,width] = size(img);

% ----------------set matrix----------------
% set Gauss sensing matrix: Phi
Sampling_Rate = 0.25;
M = floor(height*Sampling_Rate);
N = height;
Phi = randn(M,N)/sqrt(M);

% set Psi: DFT matrix
Psi_DFT = fft(eye(height))/sqrt(height);

% set Psi: 1D DCT matrix
Psi_DCT = zeros(height,height);
 for j = 1:height
     for k = 1:height
        Psi_DCT(j,k) = cos((2*k-1)*(j-1)*pi/(2*height));
     end
     if j==1
         Psi_DCT(j,:) = sqrt(1/height).*Psi_DCT(j,:);
     else
        Psi_DCT(j,:) = sqrt(2./height).*Psi_DCT(j,:);
     end
 end

% set Theta
Theta = Phi * Psi_DCT;

% ---------------compression---------------
img_cs = Phi * img;

% -------------------IHT-------------------
% set sparsity
s_ratio = 0.1;

% set receive matrix
spar_mat = zeros(height,width);

% execute IHT recovery
tic
for i = 1:width
    column = IHT(img_cs(:,i),Theta,s_ratio,height);
    spar_mat(:,i) = column;
end
img_rec = Psi_DCT * spar_mat;
toc

% -----------------results-----------------
figure;

% show original image
subplot(121);
imshow(img,[]);
title('original image');

% show IHT recovered image
subplot(122);
imshow(img_rec,[]);
title('IHT recovered image');

PSNR_j = 20*log10(255/sqrt(mean((img(:)-img_rec(:)).^2)));
disp(['Sampling Rate = ' num2str(Sampling_Rate)]);
disp(['PSNR = ' num2str(PSNR_j)]);