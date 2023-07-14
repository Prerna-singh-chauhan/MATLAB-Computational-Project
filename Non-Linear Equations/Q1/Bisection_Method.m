f = str2func(strcat('@(x)',input("Enter a function in x: ","s")));
anod = input("Enter starting point 1: ");
bnod = input("Enter starting point 2: ");
n_max = input("Enter maximum no. of iterations: ");
err_max = input("Enter maximum error: ");

n=1; a = anod; b = bnod; 
err = 100.*ones(1,n_max);
flag=0;

while n<=n_max
    if n>1
        if err(1,n-1)<err_max
            break;
        end
    end
    if f(a)*f(b)>0
        disp("No root between "+a+" and "+b);
        flag=1;
        break;
    elseif f(a)==0
            disp("The root is "+a);
            flag=1;
            break;
    elseif f(b)==0
            disp("The root is "+b);
            flag=1;
            break;
    else
         if n==1
             temp=0;
         else
             temp=xmid;
         end
         xmid = (a+b)/2;
         if f(xmid)==0
             disp("The root is "+xmid);
             n=n+1;
             flag=1;
             break;
         elseif f(xmid)*f(a)<0
             b = xmid;
         else
             a = xmid;
         end
    end
    err(1,n) = abs((xmid-temp)*100/xmid);
    n=n+1;
end

if flag==0
    fprintf("The root is %f",xmid);
end

%Plots
tiledlayout(2,1)

%Plot of f(x) vs x
nexttile
fplot(f,[anod-5 bnod+5])
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
