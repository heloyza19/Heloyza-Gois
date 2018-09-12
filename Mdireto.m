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



Dados.posicao=[3 3; 5 3; 5 7; 8 7;6 5];              %Posições dos centros
Dados.velocidade=[20 0;-30 0; -50 0; 35 0; 50 0];     %Velocidades
Dados.massa=[2.5; 2; 2.5; 2; 2.5];                   %Massas
Dados.raio=[0.5; 0.5; 0.5; 0.5;0.5];                 %Raios
Dados.forcaext=[0 0;0 0;0 0;0 0;0 0];                %Forças externas
Dados.forcacont=[0 0;0 0;0 0;0 0;0 0];               %Forças de contato


%determincação do dt
m=max(Dados.massa);
tc=2*sqrt(m/Kn);
e=0.1;
dt=e*tc;
times = 0 : dt : 0.2;

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
    Ek=0;
    Epe(k)=0;
    figure(1)
    for l=1:1:ne
       X=Dados.raio(l)*cos(teta)+Dados.posicao(l,1);
       Y=Dados.raio(l)*sin(teta)+Dados.posicao(l,2);
       plot(X,Y);fill(X,Y,'k');
       hold on
    end
    plot([0 L],[0 0],'k',[0 L],[H H],'k',[0 0],[0 H],'k',[L L],[0 H],'k','LineWidth',5); hold off;
    axis([-0.1,L+0.1,-0.1,H+0.1]); 
    xlabel('Coordenada x (m)');
    ylabel('Coordenada y (m)');
    
    
    %Colisão com a parede
   for b=1:1:ne
        Tr=Dados.raio(b);
        T1=Dados.posicao(b,1);
        T2=Dados.posicao(b,2);
        [Dados,Ee]=contato(Dados,campo,ne,b,Xmin,Ymin,dx,Cn,Kn);
        Epe(k)=Epe(k)+Ee;
        if (T1 <= Tr) || (T1 >= (L-Tr))
            Dados.velocidade(b,1)=-Dados.velocidade(b,1);
           
        end
        if (T2 <= Tr) || (T2 >= (H-Tr))
            Dados.velocidade(b,2)=-Dados.velocidade(b,2);   
        end
   end
   
   %Colisão entre partículas
   
   %Colisão entre as partícula
   %for c=1:1:ne
    
   %end
   
    %Integração temporal
    Fres=Dados.forcaext+Dados.forcacont;

    for e=1:1:ne 
         E=cinetica(Dados,e);
         Ek=Ek+E;
        [Dados,campo]=atualizadados(e,Dados,campo,Fres,Xmin,Ymin,dx,dt);
    end
     Ec(k)=Ek;
   
    Dados.forcacont=[0 0;0 0;0 0;0 0;0 0];
    frame=getframe(gcf);
    writeVideo(v,frame);
   
    end

figure (2)
plot(times,Ec,times,Epe)
legend('Energia cinética','Energia elástica')
close(v);


