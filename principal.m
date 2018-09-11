clear all; clc;
close all;
d=10;
h=10;

%Polígono
%na=input('número de vértices:');         %número de arestas
pt=[1 1; 2 3;2 5; 1 4];
X=[ 1 2 2 1 ];
Y=[1 3 5 4 ];
%[pt,x,y]=poligono(na);                   %coordenadas
Np=length(pt);


%Número de bolinhas
Nb=10;

X(Np+1)=X(1);
Y(Np+1)=Y(1);


for i=1:1:Np
 L=norm([X(i+1)-X(i) Y(i+1)-Y(i)]);
 Raio=L/(2*Nb);
 s=Raio:2*Raio:(X(i+1)-Raio);
 for j=1:1:length(s)
    Xb(i,j)=X(i)+(s(j)/L)*(X(i+1)-X(i));
    Yb(i,j)=Y(i)+(s(j)/L)*(Y(i+1)-Y(i));
 end
end

plot(X,Y);fill(X,Y,'w');
%plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5);
axis([-0.1,d+0.1,-0.1,h+0.1]); 
xlabel('Coordenada x (m)');
ylabel('Coordenada y (m)');