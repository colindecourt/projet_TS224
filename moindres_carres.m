function [ a0,a1 ] = moindres_carres( y_init, N, L)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


a0=[];
a1=[];
for l=1:L
    x_mean=0;
    y_mean=0;
    xy_mean=0;
    x_mean2 = 0;
    for n=1:N
        x_mean=x_mean+((l-1)*N+n);
        x_mean2 = x_mean2 + ((l-1)*N+n)^2;
        y_mean=y_mean+y_init((l-1)*N+n); 
        xy_mean=xy_mean+((l-1)*N+n)*(y_init((l-1)*N+n));
    end 
    x_mean=1/N*x_mean;
    y_mean=1/N*y_mean;
    xy_mean=1/N*xy_mean;
    x_mean2 = 1/N*x_mean2;
    a0 = [a0 y_mean/(1+x_mean)];
    a1 = [a1 xy_mean/(x_mean+x_mean2)];
end 
  


end

