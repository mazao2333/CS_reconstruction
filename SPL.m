function [x_next,D] = SPL(xn,y,PhiB,Psi,height,width,B,N,ite)

% set param
Lambda = 6 * 0.6^ite;

% col->img, Wiener filtering, img->col
x1 = col2im(xn,[B B],[height width],'distinct');
x_W = wiener2(x1,[3 3]);
x_W_col = im2col(x_W,[B B],'distinct');

x2 = x_W_col + PhiB' * (y - PhiB * x_W_col);

% Threshold
x3 = Psi' * x2;
x4 = Thr(x3,Lambda,N);
x5 = Psi * x4;

x_next = x5 + PhiB' * (y - PhiB * x5);

D = norm((x_next(:)-x2(:)),2) / sqrt(N);