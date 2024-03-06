
L = 200;
x=(-5:10/L:5);
x2 = (-5:5);
Noise = 0.5*rand(1,(L+1))*2-1.0;
N_team = 2;
%y=N_team.*x.^2+3+N_team;
%y2=N_team.*x2.^2+3+N_team;
y = x.^2.*sin(2*x+pi/2)+Noise
y2 = x2.^2.*sin(2*x2+pi/2)

p=polyfit(x,y,12);
p1=polyval(p,x);

plot(x,p1,'o');
hold on 
plot(x2,y2,'*')




