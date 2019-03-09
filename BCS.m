% -------------------init-------------------
clear;

% read image
img = imread('test_image/lena.bmp');
img = double(img);
[height,width] = size(img);
N = height * width;

% ----------------set matrix----------------
% set blocks' size
B = 32;

% set Gauss sensing matrix: PhiB
Sampling_Rate = 0.25;
MB = round(B*B*Sampling_Rate);
PhiB = orth(randn(B*B,B*B))';
PhiB = PhiB(1:MB,:);

% ---------------compression---------------
% block the image
x_col = im2col(img,[B,B],'distinct');
[x_col_h,x_col_w] = size(x_col);

% set Psi: 2D DCT matrix
Psi_2DCT = zeros(B*B,B*B);
for row = 1:B
  for col = 1:B
    X = zeros(B,B);
    X(row,col) = 1;
    x = idct2(X);
    Psi_2DCT(:,(row-1)*B+col) = x(:);
  end
end

% execute compression
y = PhiB * x_col;

% -----------------rebuilt-----------------
% set init value
xn = PhiB' * y;
Di1 = norm(xn,2) / sqrt(N);
Di = 0;
ite = 0;

% rebuilt
disp('Reconstruction time:');
tic
while(abs(Di1-Di)>0.0001)
    [x_T,D_T] = SPL(xn,y,PhiB,Psi_2DCT,height,width,B,N,ite);
    xn = x_T;
    Di = Di1;
    Di1 = D_T;
    ite = ite + 1;
end
toc

% for i = 1:ite
%     x_T = SPL(xn,y,PhiB,Psi_2DCT,height,width,B,N,i);
%     xn = x_T;
% end

img_re = col2im(xn,[B B],[height,width],'distinct');

% -----------------results-----------------
figure;

% show original image
subplot(121);
imshow(img,[]);
title('original image');

% show SPL recovered image
subplot(122);
imshow(img_re,[]);
title('SPL recovered image');

PSNR_k = 20*log10(255/sqrt(mean((img(:)-img_re(:)).^2)));
disp(['Sampling Rate = ' num2str(Sampling_Rate)]);
disp(['PSNR = ' num2str(PSNR_k)]);
disp(['Iteration = ' num2str(ite)]);