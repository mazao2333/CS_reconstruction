function x4 = Thr(x3,Lambda,N)

% set threshold value
thr_val = Lambda * sqrt(2 * log(N)) * (median(abs(x3(:))) / 0.6745);

% thresholding
x3(abs(x3)<thr_val) = 0;

x4 = x3;