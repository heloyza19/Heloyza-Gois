function [pt,x,y]=poligono(na)

for i=1:1:na
   p=str2num(input('coordenadas do v�rtice:','s'));  %coordenadas x e y separadas por espa�o
   x(i)=(p(1));
   y(i)=(p(2));
   
   pt(i,1)=x(i);
   pt(i,2)=y(i);
   
 
   end
end