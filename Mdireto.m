clc; close (figure)
clear all;
% Condicoes iniciais
L = 10;      %Largura da parede (m)
H = 10;      %Altura da parede (m)
Xmin=0;
Xmax=L;
Ymin=0;
Ymax=H;
teta=0:0.1:2*pi;

%Mola
Cn=0;         %Constante de amortecimento (Normal)
Kn=1000000;   %Constante da mola (Normal) 



Dados.posicao=[3 3; 5 9; 5 7; 8 5;6 5];              %Posições dos centros
Dados.velocidade=[20 50;0 40; 0 -60; 15 0; 50 0];     %Velocidades
Dados.massa=[2.5; 2; 2.5; 2; 2.5];                   %Massas
Dados.raio=[0.5; 0.5; 0.5; 0.5;0.5];                 %Raios
Dados.forcaext=[0 0;0 0;0 0;0 0;0 0];                %Forças externas
Dados.forcacont=[0 0;0 0;0 0;0 0;0 0];               %Forças de contato
%determincação do dt
m=max(Dados.massa);
tc=2*sqrt(m/Kn);
e=0.1;
dt=e*tc;
times = 0 : dt : 1;

%Grid
dx=2*max(Dados.raio);
dy=dx;
ne=length(Dados.posicao);                                                                                               
N=ceil((Xmax-Xmin)/dx);
M=ceil((Xmax-Xmin)/dy);

campo=cell(N,M);

for n=1:1:ne
   [c1,c2]=mapeamento(Dados.posicao(n,1),Dados.posicao(n,2),Xmin,Ymin,dx);
   campo{c1,c2}=[campo{c1,c2},n];
end

set(gca,'nextplot','replacechildren'); 
v = VideoWriter('mapeamentodireto.avi');
open(v);


for k=1:1:length(times)
    %Plot
    X1=Dados.raio(1)*cos(teta)+ Dados.posicao(1,1);
    Y1=Dados.raio(1)*sin(teta)+ Dados.posicao(1,2);
    X2=Dados.raio(2)*cos(teta)+ Dados.posicao(2,1);
    Y2=Dados.raio(2)*sin(teta)+ Dados.posicao(2,2);
    X3=Dados.raio(3)*cos(teta)+ Dados.posicao(3,1);
    Y3=Dados.raio(3)*sin(teta)+ Dados.posicao(3,2);
    X4=Dados.raio(4)*cos(teta)+ Dados.posicao(4,1);
    Y4=Dados.raio(4)*sin(teta)+ Dados.posicao(4,2);
    X5=Dados.raio(5)*cos(teta)+ Dados.posicao(5,1);
    Y5=Dados.raio(5)*sin(teta)+ Dados.posicao(5,2);
    plot(X1,Y1); fill(X1,Y1,'b'); hold on;
    plot(X2,Y2); fill(X2,Y2,'r');
    plot(X3,Y3); fill(X3,Y3,'y');
    plot(X4,Y4); fill(X4,Y4,'g');
    plot(X5,Y5); fill(X5,Y5,'k');
    plot([0 L],[0 0],'k',[0 L],[H H],'k',[0 0],[0 H],'k',[L L],[0 H],'k','LineWidth',5); hold off;
    axis([-0.1,L+0.1,-0.1,H+0.1]); 
    xlabel('Coordenada x (m)');
    ylabel('Coordenada y (m)');
    
    %Colisão com a parede
   for b=1:1:ne
        Tr=Dados.raio(b);
        T1=Dados.posicao(b,1);
        T2=Dados.posicao(b,2);
        
        if (T1 <= Tr) || (T1 >= (L-Tr))
            Dados.velocidade(b,1)=-Dados.velocidade(b,1);
           
        end
        if (T2 <= Tr) || (T2 >= (H-Tr))
            Dados.velocidade(b,2)=-Dados.velocidade(b,2);   
        end
   end
   
   %Colisão entre partículas
   
   %Colisão entre as partícula
   for c=1:1:ne
    [Dados]=contato(Dados,campo,ne,c,Xmin,Ymin,dx,Cn,Kn);
   end
   
    %Integração temporal
    Fres=Dados.forcaext+Dados.forcacont;

    for e=1:1:ne  
        [Dados,campo]=atualizadados(e,Dados,campo,Fres,Xmin,Ymin,dx,dt);
    end
    Dados.forcacont=[0 0;0 0;0 0;0 0;0 0];
    frame=getframe(gcf);
    writeVideo(v,frame);
   
    end


close(v);


