
fprintf("Give your no. of data and data points in a file named 'input_least.txt'\n");
m= input('Please enter the degree of the polynomial for regression \n');
fid = fopen("input_least.txt");

n =fscanf(fid,"%d",1);
arr = fscanf(fid,"%f",[2,n]);
fclose(fid);
arr=arr';
A=ones(m,m);%matrix A

arr

for i=1:m+1
	k=i-1;
	for j=1:m+1
 		s=sum(arr,1,n,k+j-1);
     	A(i,j)=s;
	end
end
R = ones(m+1,1);% resultant matrix
for i=1:m+1
	k=i-1;
  s2=0;
	for j=1:n
		s2=s2+(arr(j,1).^k)*arr(j,2);
	end
	R(i,1)=s2;
end

C = A\R;%coefficient matrix

poly=@(t) 0;% defined polynomials to draw graph
for i=1:m+1
	poly=@(t) poly(t) + C(i)*(t.^(i-1));
end
fplot(poly,[arr(1,1),arr(n,1)+0.1],'color','b');%graph of estimated polynomial 
hold on;
plot(arr(:,1),arr(:,2),'x','color','r')%given points marked on the graph

for i=1:n
	yeval(i)= feval(poly,arr(i,1));
end

[fbar] = sum(arr,2,n,0)/n;
s3=0;
for i=1:n
	s3=s3+(arr(i,2)-fbar).^2;
end
St=s3;
s3=0;
for i=1:n
	s3=s3+(arr(i,2)-yeval(i)).^2;
end
Sr=s3;
r = ((St-Sr)/St);

fileId = fopen('output_least.txt','w');
  fprintf(fileId,"Coefficient are :\n");
	fprintf(fileId,'%f \n',C);
	fprintf(fileId,'R-sq is : %f',r);
fclose(fileId);

function [s] = sum(arr,k,n,p)
	s=0;
	for i=1:n
		s=s+(arr(i,k).^p);
	end
end