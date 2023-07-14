f = str2func(strcat('@(x)',input("Enter a function in x: ","s")));
g = str2func(strcat('@(x)',input("Enter a function such that x=g(x): ","s")));
xnod = input("Enter starting point: ");
n_max = input("Enter maximum no. of iterations: ");
err_max = input("Enter maximum error: ");

n=1; xa = xnod;  
err = 100.*ones(1,n_max);
flag=0;

while n<=n_max
    if n>1
        if err(1,n-1)<err_max
            break;
        end
    end
    if f(xa)==0
            fprintf("The root is %f",xa);
            flag=1;
            break;
    else
         temp=xa;
         xa = g(xa);
    end
    err(1,n) = abs((xa-temp)*100/xa);
    n=n+1;
end

if flag==0
    fprintf("The root is %f",xa);
end

%Plots
tiledlayout(2,1)

%Plot of f(x) vs x
nexttile
fplot(f,[xa-5 xa+5])
title("Plot of f(x) vs x")
xlabel("x")
ylabel("f(x)")
grid on

%Plot of relative approximate error vs iteration number
nexttile
xaxis = 1:1:(n-1);
yaxis = err(1,1:n-1);
plot(xaxis,yaxis)
title("Plot of relative approximate error vs iteration number")
xlabel("Iteration number")
ylabel("Relative approximate error")
grid on
