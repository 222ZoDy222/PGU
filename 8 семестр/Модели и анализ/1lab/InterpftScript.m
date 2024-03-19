clear
clc
x = (2:0.1:4);
x1 = (2:0.01:4);
xCool = (2:0.001:4);
yCool = cos(exp(xCool))./sin(log10(xCool));

% �������� �������
y = cos(exp(x))./sin(log10(x));

%������������ ����� ����� 
y1=interpft(y,201);

plot(x,y, '-');
hold on;
plot(x1, y1,'--');
plot(xCool,yCool, '-');


