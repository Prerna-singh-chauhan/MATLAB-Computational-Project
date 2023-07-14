file = input("Choose method to find the root. Type: \n 1 for Bisection Method \n 2 for False-Position Method \n 3 for Fixed-Point Method \n 4 for Newton-Raphson Method \n 5 for Secant Method \n So which method do you like to use: ");
if file==1
    Bisection_Method
elseif file==2
    False_Position_Method
elseif file==3
    Fixed_Point_Method
elseif file==4
    Newton_Raphson_Method
elseif file==5
    Secant_Method
else
    disp("Error!")
end