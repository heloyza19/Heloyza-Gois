clear all; clc;
close all;
d=10;
h=10;

%Polígono
%na=input('número de vértices:');         %número de arestas
pt=[1 1; 2 1;2 2];
X=pt(:,1);
Y=pt(:,2);
plot(X,Y);fill(X,Y,'w');
%[pt,x,y]=poligono(na);                   %coordenadas
Np=length(X);

V=[10 0];
dt=0.01;
times=0:dt:1;
Pb=cell(Np,2);
%Número de bolinhas
Nb=10;

X(Np+1)=X(1);
Y(Np+1)=Y(1);
for i=1:1:Np
 L(i)=norm([X(i+1)-X(i) Y(i+1)-Y(i)]);    %Comprimento do  segmento
 Raio(i)=L(i)/(2*Nb);                     %Raio da bola no segmento
 s=Raio(i):2*Raio(i):(L-Raio(i));            %Parâmetro da curva
 
 for j=1:1:Nb
    Pb{i,1}(j)=X(i)+(s(j)/L(i))*(X(i+1)-X(i));
    Pb{i,2}(j)=Y(i)+(s(j)/L(i))*(Y(i+1)-Y(i));
 end
 
end

%for t=1:1:length(times)

figure(1)
teta=0:0.1:2*pi;
for k=1:1:Np
    
    %Adicionar dinâmica
   for l=1:1:Nb 
       Xe=Pb{k,1}(l)+cos(teta)*Raio(k);
       Ye=Pb{k,2}(l)+sin(teta)*Raio(k);
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
%end