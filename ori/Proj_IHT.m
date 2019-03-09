%projection
img_cs = Phi * img;
% treat each column as a independent signal: [y]

%recover using iht
sparse_rec = zeros(height,width);
s_ratio = 0.2;
for i=1:width
    column_rec = IHT(img_cs(:,i),Theta,s_ratio,height);
    sparse_rec(:,i) = column_rec';           % sparse representation
end
img_rec = Psi * sparse_rec;          % inverse transform

%upside down
img_ud = zeros(height,width);
for i=1:height
    for j=1:width
        img_ud(i,j) = img_rec(height-i+1,j);
    end
end