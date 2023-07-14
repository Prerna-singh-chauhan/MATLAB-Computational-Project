syms x
f = str2sym(input("Enter a polynomial in x: ","s"));
r = input("Enter starting value1: ");
s = input("Enter starting value2: ");
k_max = input("Enter maximum no. of iterations: ");
err_max = input("Enter maximum error: ");

a = flip(sym2poly(f));
n = polynomialDegree(f);
b = zeros(1,n+1);
c = zeros(1,n+1);

err = 100.*ones(1,k_max);
k=1;

while k<=k_max
    if k>1
        if err(1,k-1)<err_max
            break;
        end
    end
    b(n+1) = a(n+1);
    b(n) = a(n) + r*b(n+1);
    for i = n-1:-1:1
        b(i) = a(i) + r*b(i+1) + s*b(i+2);
    end
    c(n+1) = b(n+1);
    c(n) = b(n) + r*c(n+1);
    for i = n-1:-1:1
        c(i) = b(i) + r*c(i+1) + s*c(i+2);
    end
    syms p
    syms q
    eqn1 = c(3)*p + c(4)*q == -b(2);
    eqn2 = c(2)*p + c(3)*q == -b(1);
    [del_r, del_s] = solve([eqn1, eqn2], [p,q]);
    err1 = abs(del_r*100/r);
    err2 = abs(del_s*100/s);
    err(1,k) = max(err1, err2);
    r = r + del_r;
    s = s + del_s;
    k=k+1;
end

roots = [(r+sqrt(r*r+4*s))/2 , (r-sqrt(r*r+4*s))/2];
fprintf("The roots are %f and %f",roots(1), roots(2));

%Plot
fplot(f, [-10 10]);
title("Plot of f(x) vs x")
xlabel("x")
ylabel("f(x)")
grid on

