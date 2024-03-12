
L = 200;
x = (2:4);
x2 = (2:4);

N_team = 2;

%cos(exp(x))/sin(ln(x)), x?[2,4]  

y = cos(exp(x))/sin(log(x));
y2 = cos(exp(x2))/sin(log(x2));

p=polyfit(x,y,3);
p1=polyval(p,x);

plot(x,p1,'o');
%hold on 
%plot(x2,y2,'*')




