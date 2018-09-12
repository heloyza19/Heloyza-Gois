function  [Dados,Ee]=contato(Dados,campo,ne,c,Xmin,Ymin,dx,Cn,Kn) 
Xa=Dados.posicao(c,1);
Ya=Dados.posicao(c,2);
Ee=0;
[P1,P2]=mapeamento(Xa,Ya,Xmin,Ymin,dx);
c1=-1;
c2=1;
C1=-1;
C2=1;
if P1==1
    c1=0;
elseif P1==10
    c2=0;
end
if P2==1
  C1=0;
elseif P2==10
  C2=0;
end

 for ca=c1:1:c2                       %Verifica nas células vizinhas   (x-1,x+0,x+1)
    for cb=C1:1:C2                                                    %(Y-1,y+0,Y+1) 
      tc=length(campo{P1+ca,P2+cb});  %Tamanho da célula     
           if (tc)>0                  %Se a célula vizinha não for vazia, verifica o contato
             for cc=1:1:tc
                p=(campo{P1+ca,P2+cb}(cc));      %Verifica os elementos da célula
                if p>c
                    Xb=Dados.posicao(p,1);
                    Yb=Dados.posicao(p,2);
                    D=sqrt(((Xa-Xb)^2)+ ((Ya-Yb)^2));
                    if D<(Dados.raio(c)+Dados.raio(p))
                        N=[(Xa-Xb)/D (Ya-Yb)/D];
                        Fn=Fnormal(N,Cn,Kn,Dados.velocidade(c,1),Dados.velocidade(c,2),Dados.velocidade(p,1),Dados.velocidade(p,2),Dados.raio(c),Dados.raio(p),D);
                        Dados.forcacont(c,1)=Dados.forcacont(c,1)+Fn(1);
                        Dados.forcacont(c,2)=Dados.forcacont(c,2)+Fn(2);
                        Dados.forcacont(p,1)=Dados.forcacont(p,1)-Fn(1);
                        Dados.forcacont(p,2)=Dados.forcacont(p,2)-Fn(2);
                        Ee=Ee+0.5*Kn*((Dados.raio(c)+Dados.raio(p))-D)^2;
                          end
                    end
                  end       
          end
    end 
 end
