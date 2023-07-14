f = str2func(strcat('@(x)',input("Enter a function in x: ","s")));
anod = input("Enter starting point1: ");
bnod = input("Enter starting point2: ");
n_max = input("Enter maximum no. of iterations: ");
err_max = input("Enter maximum error: ");

n=1; xa = anod; xb = bnod;
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
    elseif f(xb)==0
            fprintf("The root is %f",xb);
            flag=1;
            break;
    else
         temp=xb;
         xb = xb - f(xb)*(xb-xa)/(f(xb)-f(xa));
         xa=temp;
    end
    err(1,n) = abs((xb-xa)*100/xb);
    n=n+1;
end

if flag==0
    fprintf("The root is %f",xa);
end

%Plots
tiledlayout(2,1)

%Plot of f(x) vs x
nexttile
fplot(f,[xb-5 xb+5])
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