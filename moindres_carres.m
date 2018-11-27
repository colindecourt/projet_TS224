function [ a0,a1 ] = moindres_carres( y_init, N, L)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

x_mean=0;
y_mean=0;
xy_mean=0;
a0=[];
a1=[];
for l=2:L+1
    for n=1:N
        x_mean=x_mean+((l-1)*N+n);
        y_mean=y_mean+((y_init(l-1)*N)+n); 
        xy_mean=xy_mean+(((l-1)*N+n)*(y_init(l-1)*N)+n);
    end 
    x_mean=1/N*x_mean;
    y_mean=1/N*y_mean;
    xy_mean=1/N*xy_mean;
    a0 = [a0 y_mean/(1+x_mean)];
    a1 = [a1 xy_mean/(x_mean+x_mean^2)];
end 
  


end

