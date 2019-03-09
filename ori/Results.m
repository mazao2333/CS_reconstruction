%show the results
figure;

subplot(1,2,1);
imshow(img,[]),title('original image');

% subplot(2,2,2);
% imagesc(Phi),title('measurement mat');

% subplot(2,2,3);
% imagesc(Psi),title('base mat');

subplot(1,2,2);
% imshow(img_rec,[]),title(strcat('rec img'));
imshow(img_ud,[]),title(strcat('rec img'));

%psnr = 20*log10((N-1)/sqrt(mean((img(:)-img_rec(:)).^2)))