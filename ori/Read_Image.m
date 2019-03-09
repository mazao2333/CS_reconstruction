clear;

%read image
img = imread('test_image/honkai.bmp');
img = double(img);
[height,width] = size(img);