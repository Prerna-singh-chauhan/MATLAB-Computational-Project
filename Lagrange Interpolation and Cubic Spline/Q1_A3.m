+fprintf("Enter the method you want to use\n");
method=input('1. Lagrange polynomial\n 2. Cubic spline\n','s');

    if method=='1'
        
clear;

fid = fopen('lagrange interpolation question.txt');
n = fscanf(fid,"%d",1);
% B = zeros(n,2);
B = fscanf(fid,"%f",[2,n]);
B=B';
% line =fgetl(fid);
% m = sscanf(line, '%f ');
m = fscanf(fid,"%d",1);
Q = zeros(m,2);
for i=1:1:m
  Q(i,1) = fscanf(fid,'%f',1);
end

fclose(fid);

  for i=1:m
    Q(i,2) = polynomial(Q(i,1),B,n,m);
  end
  
  figure;
  for i=1:n
    plot(B(i,1),B(i,2),'*r',"markersize",20);
    hold on;
  end
  for i=B(1,1):0.01:B(n,1)
    plot(i,polynomial(i,B,n,m),'.y',"markersize",5);
    hold on;
  end

  
  hold on;
  
  filename = 'lagrange_interpolation_output.txt';
  fileID = fopen (filename, 'w');
  fprintf(fileID , "Lagrange Polynomial Method\n(X ,Y) is\n");
%    fprintf(fileID , '%f\n',Q);
for i =1:m
    fprintf(fileID,'%f %f\n',Q(i,1),Q(i,2));
end
  fclose(fileID);
 
    else
        x = [];
        y = [];
        X = [];
        fileid=fopen('cubic_spline_input.txt','r');
        data = textscan(fileid, '%*s %*s %*s %*s\n');
        data = textscan(fileid, '%f %f');
        x(1:numel(data{1}), 1) = data{1};
        y(1:numel(data{2}), 1) = data{2};
        data = textscan(fileid, '%*s %*s %*s %*s %*s %*s %*s %*s\n');
        data1 = textscan(fileid, '%f ');
        X(1:numel(data1{1}), 1) = data1{1};
        fclose(fileid);
        Naturalspline(x,y,X);



    end
     function [y] = polynomial (x,B,n,m)
  P = ones(n,1);
  for i=1:n
    for j=1:n
      if(i~=j)
        P(i,1)=P(i,1).*(x-B(j,1))/(B(i,1)-B(j,1));
      end
    end
  end
  y=0;
  for i=1:n
    y=y+B(i,2)*P(i,1);
  end
  end

function  [Y] = Naturalspline(x,y,X)
n=length(x);
h=zeros(n-1,1);
for i=1:n-1
    h(i,1)=x(i+1,1)-x(i,1);
end
a=zeros(n,n);
a(1,1)=1;
a(n,n)=1;
for i=2:n-1
    a(i,i-1)=h(i-1,1);
    a(i,i)=2*(h(i-1,1)+h(i,1));
    a(i,i+1)=h(i,1);
end
b=zeros(n,1);
g=zeros(n,1);
for i=2:n
    g(i,1) = (y(i,1)-y(i-1,1))/h(i-1,1);
end
for i=2:n-1
    b(i,1) = 6*(g(i+1,1)-g(i,1));
end
sigma=inv(a)*b;
A=zeros(n-1,1);
B=zeros(n-1,1);
C=zeros(n-1,1);
D=zeros(n-1,1);
for i=1:n-1
    A(i,1)=sigma(i+1,1)/(6*h(i,1));
    B(i,1)=sigma(i,1)/(6*h(i,1));
    C(i,1)=(y(i+1,1)/h(i,1))-(sigma(i+1,1)*h(i,1)/6);
    D(i,1)=(y(i,1)/h(i,1))-(sigma(i,1)*h(i,1)/6);
end

i = ones(size(X));
for j=1:n
    i(x(j,1) <= X) = j;
end
Y=A(i,1).*((X-x(i,1)).^3)-B(i,1).*((X-x(i+1,1)).^3)+C(i,1).*(X-x(i,1))-D(i,1).*(X-x(i+1,1));
fileid=fopen('cubic_spline_output.txt','w');
fprintf(fileid,'%s','Interpolated values of y* at given x* ');
fprintf(fileid,'\n');
fprintf(fileid,'%s','Natural Cubic Spline: ');
fprintf(fileid,'\n');
for i=1:size(X)
    fprintf(fileid,'%.4f %.4f\n',X(i,1),Y(i,1));
end
fclose(fileid);
type('cubic_spline_output.txt');
plot(x,y,'ro');
hold on;
for i=1:n-1
    x1=x(i,1):0.001:x(i+1,1);
    y1=A(i,1).*((x1-x(i,1)).^3)-B(i,1).*((x1-x(i+1,1)).^3)+C(i,1).*(x1-x(i,1))-D(i,1).*(x1-x(i+1,1));
    k=plot(x1,y1,'g');
end
xlabel('x');
ylabel('y');
legend(k,'Natural Cubic Spline');
hold on;
end