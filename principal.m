clear all; clc;
close all;
d=10;
h=10;

%Polígono
%na=input('número de vértices:');         %número de arestas
%pt=[1 1; 2 3;2 5; 1 4];
X=[ 1 2 2 1 ];
Y=[1 1 2 2];
%[pt,x,y]=poligono(na);                   %coordenadas
Np=length(X);


%Número de bolinhas
Nb=2;

X(Np+1)=X(1);
Y(Np+1)=Y(1);

j=0;
for i=1:1:Np
 L(i)=norm([X(i+1)-X(i) Y(i+1)-Y(i)]);
 Raio(i)=L(i)/(2*Nb);
 s=Raio:2*Raio(i):(L-Raio(i));
 for j=1:1:length(s)
    Xb(i,j)=X(i)+(s(j)/L(i))*(X(i+1)-X(i));
    Yb(i,j)=Y(i)+(s(j)/L(i))*(Y(i+1)-Y(i));
 end
end
figure(1)
teta=0:0.1:2*pi;
for i=1:1:Np
   for j=1:1:Nb 
       Xe=Xb(i,j)+cos(teta)*Raio(i);
       Ye=Yb(i,j)+sin(teta)*Raio(i);
       plot(Xe,Ye);
       hold on
   end
end
plot(X,Y);fill(X,Y,'w');
hold off

%plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5);
axis([-0.1,d+0.1,-0.1,h+0.1]); 
xlabel('Coordenada x (m)');
ylabel('Coordenada y (m)');