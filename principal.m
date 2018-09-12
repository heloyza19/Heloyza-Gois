clear all; clc;
close all;
d=10;
h=10;

%Polígono
%na=input('número de vértices:');         %número de arestas
pt=[1 1; 2 1;2 2; 1 2];
X=pt(:,1);
Y=pt(:,2);
%[pt,x,y]=poligono(na);                   %coordenadas
Np=length(X);

Pb=cell(Np,2);
%Número de bolinhas
Nb=10;

X(Np+1)=X(1);
Y(Np+1)=Y(1);

j=0;
for i=1:1:Np
 L(i)=norm([X(i+1)-X(i) Y(i+1)-Y(i)]);
 Raio(i)=L(i)/(2*Nb);
 s=Raio:2*Raio(i):(L-Raio(i));
 for j=1:1:length(s)
    Pb{i,1}(j)=X(i)+(s(j)/L(i))*(X(i+1)-X(i));
    Pb{i,2}(j)=Y(i)+(s(j)/L(i))*(Y(i+1)-Y(i));
 end
end
figure(1)
teta=0:0.1:2*pi;
for i=1:1:Np
   for j=1:1:Nb 
       Xe=Pb{i,1}(j)+cos(teta)*Raio(i);
       Ye=Pb{i,2}(j)+sin(teta)*Raio(i);
       plot(Xe,Ye,'r');
       hold on
   end
end
plot(X,Y);fill(X,Y,'w');
hold off

%plot([0 d],[0 0],'k',[0 d],[h h],'w',[0 0],[0 h],'w',[d d],[0 h],'w','LineWidth',5);
axis([-0.1,d+0.1,-0.1,h+0.1]); 
xlabel('Coordenada x (m)');
ylabel('Coordenada y (m)');