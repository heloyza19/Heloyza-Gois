function  [Dados,campo]=atualizadados(e,Dados,campo,Fres,Xmin,Ymin,dx,dt)
[I0,J0]=mapeamento(Dados.posicao(e,1),Dados.posicao(e,2),Xmin,Ymin,dx);
Fr_x=Fres(e,1);
Fr_y=Fres(e,2);
        
vx=Dados.velocidade(e,1);
vy=Dados.velocidade(e,2);
r=Dados.raio(e);
m=Dados.massa(e);
ax=Fr_x/m;
ay=Fr_y/m;
        
%Atualiza velocidade
nvx=vx+ax*dt;
nvy=vy+ay*dt;
        
%Atualiza posição por RK2
P1=Dados.posicao(e,1)+0.5*dt*(nvx+vx);
P2=Dados.posicao(e,2)+0.5*dt*(nvy+vy);
        
%ANÁLISE DO ESPAÇO APÓS A ATUALIZAÇÃO DA POSIÇÃO 
[I,J]=mapeamento(P1,P2,Xmin,Ymin,dx);

%Apaga a partícula da posição anterior no campo
p=find(campo{I0,J0}==e);
campo{I0,J0}(p)=[];

campo{I,J}=[campo{I,J},e];
        
%COLOCA OS DADOS ATUALIZADOS NA NOVA CÉLULA  
Dados.posicao(e,1)=P1;
Dados.posicao(e,2)=P2;
Dados.velocidade(e,1)=nvx;
Dados.velocidade(e,2)=nvy;

end

