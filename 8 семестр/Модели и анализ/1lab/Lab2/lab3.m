
x = (2:0.2:4);
% Исходная функция
y = cos(exp(x))./sin(log10(x));

hold on;
%plot(X,Y,"o");

%Net = feedforwardnet(10,'traingdx');

%Net = train(Net,X,Y);

net = feedforwardnet(10);
net = configure(net,x,y);
net = train(net,x,y);
y1 = net(x);
plot(x,y,'--',x,y1,'-')


