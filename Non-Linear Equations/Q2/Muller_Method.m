f = str2func(strcat('@(x)',input("Enter a polynomial in x: ","s")));
x3 = input("Enter starting point1: ");
x2 = input("Enter starting point2: ");
x1 = input("Enter starting point3: ");
n_max = input("Enter maximum no. of iterations: ");
err_max = input("Enter maximum error: ");

n=1; 
err = 100.*ones(1,n_max);
flag=0;

while n<=n_max
    if n>1
        if err(1,n-1)<err_max
            break;
        end
    end
    if f(x3)==0
            fprintf("The root is %f",x3);
            flag=1;
            break;
    elseif f(x2)==0
            fprintf("The root is %f",x2);
            flag=1;
            break;
    elseif f(x1)==0
            fprintf("The root is %f",x1);
            flag=1;
            break;
    else
         a = ((f(x1)-f(x2))/(x1-x2) - (f(x2)-f(x3))/(x2-x3))/(x1-x3);
         b = (f(x1)-f(x2))/(x1-x2) + a*(x1-x2);
         c = f(x1);
         if b>0
             sign_b=1;
         elseif b<0
             sign_b=-1;
         else
             sign_b=0;
         end
         del_x = - 2*c/(b+sign_b*sqrt(b*b-4*a*c));
         x3 = x2; x2 = x1; x1 = x1 + del_x;
    end
    err(1,n) = abs((x1-x2)*100/x1);
    n=n+1;
end

if flag==0
    fprintf("The root is %f",x1);
end


%Plot of f(x) vs x
fplot(f,[x1-10 x1+10])
title("Plot of f(x) vs x")
xlabel("x")
ylabel("f(x)")
grid on

