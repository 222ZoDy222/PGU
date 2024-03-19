clear
clc
x = (2:0.1:4);
x1 = (2:0.01:4);
xCool = (2:0.001:4);
yCool = cos(exp(xCool))./sin(log10(xCool));
 
y = cos(exp(x))./sin(log10(x));
%y1 = cos(exp(x1))./sin(log10(x1));

p=polyfit(x,y,8);
f=polyval(p,x1);
plot(x,y,'*');
hold on;
%plot(x,y,'-',x,f,':');
plot(x1,f,'o');
plot(xCool,yCool, '-');







