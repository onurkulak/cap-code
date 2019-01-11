% 2 layer feed forward with given weights
function [z,h,y,o] = feed_forward(w,v,img)
z = w*img;
h = tanh(z);
y = v*[h; ones(1, size(h,2))];
o = tanh(y);
end