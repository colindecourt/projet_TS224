function [] = DMA(y)
% Detrending Moving Average (DMA) 

%% Parametres

F=[];
M=length(y);
mu_y=mean(y);

%% Cr�ation du profil


for m=1:M
    somme=0;
    for i=1:m
        temp=y(i)-mu_y;
        somme=somme+temp;
    end
    y_init(m)=somme;
    
end

b = 1/M*ones(1,M);
a=1;

y_filter = filter(b,a,y_init);

end

